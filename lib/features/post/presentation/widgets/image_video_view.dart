import 'dart:io';

import 'package:flutter/material.dart';

import '/features/post/presentation/widgets/video_view.dart';

class ImageVideoView extends StatelessWidget {
  const ImageVideoView({
    super.key,
    required this.file,
    required this.fileType,
  });

  final File file;
  final String fileType;

  @override
  Widget build(BuildContext context) {
    if (fileType == 'image') {
      return Image.file(file);
    } else {
      return VideoView(
        file: file,
      );
    }
  }
}
