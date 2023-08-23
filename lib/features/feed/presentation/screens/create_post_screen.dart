import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '/core/utils/utils.dart';
import '/features/auth/presentation/widgets/round_button.dart';
import '/features/feed/presentation/widgets/mutli_image_picker.dart';
import '/features/feed/presentation/widgets/profile_info.dart';
import '/features/feed/providers/feed_provider.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({super.key});

  static const routeName = '/create-post';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      CreatePostScreenState();
}

class CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  late final TextEditingController _textController;

  bool isLoading = false;

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(height: 20),
              isLoading
                  ? const CircularProgressIndicator()
                  : RoundButton(
                      onPressed: () async {
                        setState(() => isLoading = true);
                        await ref
                            .read(feedProvider)
                            .makePost(
                              content: _textController.text,
                              images: images,
                            )
                            .catchError((_) {
                          setState(() => isLoading = false);
                        });
                        setState(() => isLoading = false);
                      },
                      label: 'Post',
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
