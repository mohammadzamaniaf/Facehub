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
        ? InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                ImageView.routeName,
                arguments: fileUrl,
              );
            },
            child: SizedBox(
              width: double.infinity,
              child: AspectRatio(
                aspectRatio: 3 / 3,
                child: Image.network(
                  fileUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        : NetworkVideoView(
            fileUrl: fileUrl,
          );
  }
}

class ImageView extends StatelessWidget {
  const ImageView({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  static const routeName = '/image-view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: double.infinity,
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
