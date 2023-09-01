import 'package:facehub/core/constants/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jiffy/jiffy.dart';

import '/core/screens/error_screen.dart';
import '/core/screens/loader.dart';
import '/core/widgets/icon_text_button.dart';
import '/core/widgets/round_like_iocn.dart';
import '/features/auth/providers/get_user_info_by_user_id_provider.dart';
import '/features/post/models/post.dart';
import '/features/post/presentation/screens/comments_screen.dart';
import '/features/post/presentation/widgets/post_image_video_view.dart';
import '/features/post/providers/post_provider.dart';
import '/features/profile/presentation/screens/profile_screen.dart';

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
            datePublished: post.datePublished,
            userId: post.posterId,
          ),
          // Post Text
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5,
            ),
            child: Text(post.content),
          ),
          // Image/Video Part
          PostImageVideoView(
            fileUrl: post.fileUrl,
            postType: post.postType,
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
            ref.read(postProvider).likeDislikePost(
                  postId: post.postId,
                  likes: post.likes,
                );
          },
          icon: isLiked
              ? FontAwesomeIcons.solidThumbsUp
              : FontAwesomeIcons.thumbsUp,
          label: 'Like',
          color: isLiked ? AppColors.blueColor : AppColors.blackColor,
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
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const RoundLikeIcon(),
        const SizedBox(width: 5),
        Text('${likes.length}'),
      ],
    );
  }
}

// Post Profile Info
class PostHeader extends ConsumerWidget {
  const PostHeader({
    super.key,
    required this.datePublished,
    required this.userId,
  });

  final DateTime datePublished;
  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(getUserInfoByUserIdProvider(userId));

    return userInfo.when(
      data: (user) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    ProfileScreen.routeName,
                    arguments: user.uid,
                  );
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    user.profilePicUrl,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.fullName,
                    style: const TextStyle(
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
      },
      error: (error, stackTrace) {
        return ErrorScreen(error: error.toString());
      },
      loading: () {
        return const Loader();
      },
    );
  }
}
