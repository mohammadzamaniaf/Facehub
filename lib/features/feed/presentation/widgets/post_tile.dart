import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jiffy/jiffy.dart';

import '/core/widgets/icon_text_button.dart';
import '/core/widgets/round_like_iocn.dart';
import '/features/feed/models/post.dart';
import '/features/feed/presentation/screens/comments_screen.dart';
import '/features/feed/providers/feed_provider.dart';

class PostTile extends StatelessWidget {
  const PostTile({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post Header part
          PostHeader(
            posterId: post.posterId,
            datePublished: post.datePublished,
          ),
          // Post Text
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5,
            ),
            child: Text(post.content),
          ),
          // Image Part
          SizedBox(
            width: double.infinity,
            child: AspectRatio(
              aspectRatio: 3 / 3,
              child: Image.network(
                post.imageUrls[0],
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 12,
            ),
            child: Column(
              children: [
                // Post Stats (Likes or comments)
                PostStatus(
                  likes: post.likes,
                ),
                const Divider(),
                // Post Buttons
                PostButtons(
                  post: post,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Post Buttons (Like, Comment, Share)
class PostButtons extends ConsumerWidget {
  const PostButtons({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLiked = post.likes.contains(FirebaseAuth.instance.currentUser!.uid);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconTextButton(
          onPressed: () {
            ref.read(feedProvider).likeDislikePost(
                  postId: post.postId,
                  likes: post.likes,
                );
          },
          icon: isLiked
              ? FontAwesomeIcons.solidThumbsUp
              : FontAwesomeIcons.thumbsUp,
          label: 'Like',
        ),
        IconTextButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              CommentsScreen.routeName,
              arguments: post.postId,
            );
          },
          icon: FontAwesomeIcons.solidMessage,
          label: 'Comment',
        ),
        const IconTextButton(
          icon: FontAwesomeIcons.share,
          label: 'Share',
        ),
      ],
    );
  }
}

// Post Likes and comments count
class PostStatus extends StatelessWidget {
  const PostStatus({
    super.key,
    required this.likes,
  });

  final List<String> likes;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const RoundLikeIcon(),
            const SizedBox(width: 5),
            Text('${likes.length}'),
          ],
        ),
        const Text('20k Comments'),
      ],
    );
  }
}

// Post Profile Info
class PostHeader extends StatelessWidget {
  const PostHeader({
    super.key,
    required this.posterId,
    required this.datePublished,
  });

  final DateTime datePublished;
  final String posterId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const CircleAvatar(
            backgroundImage: NetworkImage(
              'https://fakeimg.pl/350x200/?text=World&font=lobster',
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mike Dane',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                Jiffy.parseFromDateTime(datePublished).fromNow(),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.more_horiz),
        ],
      ),
    );
  }
}
