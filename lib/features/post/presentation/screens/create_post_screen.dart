import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '/core/screens/loader.dart';
import '/core/utils/utils.dart';
import '/features/auth/presentation/widgets/round_button.dart';
import '/features/post/presentation/widgets/image_video_view.dart';
import '/features/post/presentation/widgets/profile_info.dart';
import '/features/post/providers/post_provider.dart';

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
  File? file;
  String fileType = 'image';

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
            onPressed: makePost,
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
              // Display Image or Video
              file != null
                  ? ImageVideoView(
                      file: file!,
                      fileType: fileType,
                    )
                  : PickFileWidget(
                      pickImage: () async {
                        fileType = 'image';
                        file = await pickImage(source: ImageSource.gallery);
                        setState(() {});
                      },
                      pickVideo: () async {
                        fileType = 'video';
                        file = await pickVideo(source: ImageSource.gallery);
                        setState(() {});
                      },
                    ),
              const SizedBox(height: 20),
              isLoading
                  ? const Loader()
                  : RoundButton(
                      onPressed: makePost,
                      label: 'Post',
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> makePost() async {
    setState(() => isLoading = true);
    await ref
        .read(postProvider)
        .makePost(
          content: _textController.text,
          file: file!,
          postType: fileType,
        )
        .then((value) {
      Navigator.of(context).pop();
    }).catchError((_) {
      setState(() => isLoading = false);
    });
    setState(() => isLoading = false);
  }
}

class PickFileWidget extends StatelessWidget {
  const PickFileWidget({
    super.key,
    required this.pickImage,
    required this.pickVideo,
  });

  final VoidCallback pickImage;
  final VoidCallback pickVideo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: pickImage,
          child: const Text('Pick Image'),
        ),
        const Divider(),
        TextButton(
          onPressed: pickVideo,
          child: const Text('Pick Video'),
        ),
      ],
    );
  }
}
