import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '/core/screens/error_screen.dart';
import '/core/screens/loader.dart';
import '/core/utils/utils.dart';
import '/features/story/provider/story_provider.dart';

class CreateStoryScreen extends ConsumerStatefulWidget {
  const CreateStoryScreen({super.key});

  static const routeName = '/create-story';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateStoryScreenState();
}

class _CreateStoryScreenState extends ConsumerState<CreateStoryScreen> {
  Future<File?>? imageFuture;

  bool isLoading = false;

  @override
  void initState() {
    imageFuture = pickImage(source: ImageSource.gallery);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: imageFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }

        if (snapshot.data != null) {
          return Scaffold(
            body: Stack(
              children: [
                Center(
                  child: Image.file(snapshot.data!),
                ),
                Positioned(
                  bottom: 50,
                  right: 50,
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : FloatingActionButton(
                          onPressed: () async {
                            setState(() => isLoading = true);
                            // share story
                            await ref
                                .read(storyProvider)
                                .postStory(image: snapshot.data!)
                                .then((value) {
                              Navigator.pop(context);
                            });
                            setState(() => isLoading = false);
                          },
                          child: const Icon(
                            Icons.send,
                            size: 32,
                          ),
                        ),
                )
              ],
            ),
          );
        }

        return const ErrorScreen(error: 'No Image Selected');
      },
    );
  }
}
