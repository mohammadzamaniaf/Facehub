import 'dart:math';

import 'package:timeago/timeago.dart' as timeago;
import 'package:facehub/core/widgets/icon_text_button.dart';
import 'package:facehub/core/widgets/round_like_iocn.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/features/feed/presentation/models/post.dart';

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
              aspectRatio: 3 / 4,
              child: Image.network(
                'https://picsum.photos/200/300?random=${Random().nextInt(10)}',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 12,
            ),
            child: Column(
              children: [
                // Post Stats (Likes or comments)
                PostStatus(),
                Divider(),
                // Post Buttons
                PostButtons(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Post Buttons (Like, Comment, Share)
class PostButtons extends StatelessWidget {
  const PostButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconTextButton(icon: FontAwesomeIcons.solidThumbsUp, label: 'Like'),
        IconTextButton(icon: FontAwesomeIcons.solidMessage, label: 'Comment'),
        IconTextButton(icon: FontAwesomeIcons.share, label: 'Share'),
      ],
    );
  }
}

// Post Likes and comments count
class PostStatus extends StatelessWidget {
  const PostStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            RoundLikeIcon(),
            SizedBox(width: 5),
            Text('2.1 M'),
          ],
        ),
        Text('20k Comments'),
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
                timeago.format(datePublished),
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
