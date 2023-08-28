import 'package:flutter/material.dart';

import '/features/post/presentation/widgets/network_video_view.dart';

class PostImageVideoView extends StatelessWidget {
  const PostImageVideoView({
    super.key,
    required this.fileUrl,
    required this.postType,
  });

  final String postType;
  final String fileUrl;

  @override
  Widget build(BuildContext context) {
    return postType == 'image'
        ? SizedBox(
            width: double.infinity,
            child: AspectRatio(
              aspectRatio: 3 / 3,
              child: Image.network(
                fileUrl,
                fit: BoxFit.cover,
              ),
            ),
          )
        : NetworkVideoView(
            fileUrl: fileUrl,
          );
  }
}
