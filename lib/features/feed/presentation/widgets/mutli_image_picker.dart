import 'dart:io';

import 'package:flutter/material.dart';

import '/core/constants/app_colors.dart';

class MutliImagePickerWidget extends StatelessWidget {
  const MutliImagePickerWidget({
    super.key,
    required this.images,
    required this.onPressed,
  });

  final List<File> images;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * .25,
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          InkWell(
            onTap: onPressed,
            child: const ImageTile(),
          ),
          ...images
              .map(
                (image) => ImageTile(
                  image: image,
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}

class ImageTile extends StatelessWidget {
  const ImageTile({
    Key? key,
    this.image,
  }) : super(key: key);

  final File? image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          height: MediaQuery.of(context).size.width * .25,
          width: MediaQuery.of(context).size.width * .25,
          color: AppColors.greyColor,
          child: image != null
              ? Image.file(
                  image!,
                  fit: BoxFit.cover,
                  semanticLabel: 'Image for your post.',
                )
              : const Icon(Icons.add_a_photo),
        ),
      ),
    );
  }
}
