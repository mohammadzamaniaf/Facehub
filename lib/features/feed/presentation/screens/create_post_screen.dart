import 'dart:io';

import 'package:facehub/core/constants/app_colors.dart';
import 'package:facehub/core/utils/utils.dart';
import 'package:facehub/features/feed/presentation/widgets/mutli_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '/features/feed/presentation/widgets/profile_info.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  static const routeName = '/create-post';

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  late final TextEditingController _textController;

  // local variables
  List<File> images = [];

  @override
  void initState() {
    _textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Post'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Info (Profile Pic + Name)
            const ProfileInfo(),
            const SizedBox(height: 10),
            // Post Text Field
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'What\'s on your mind?',
                hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              minLines: 1,
            ),
            const SizedBox(height: 20),
            // Multi image picker
            MutliImagePickerWidget(
              images: images,
              onPressed: () async {
                final image = await pickImage(source: ImageSource.gallery);
                if (image != null) {
                  images.add(image);
                  setState(() {});
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
