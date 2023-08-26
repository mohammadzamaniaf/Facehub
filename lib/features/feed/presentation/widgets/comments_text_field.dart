import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/core/constants/app_colors.dart';
import '/features/feed/providers/feed_provider.dart';

class CommentTextField extends ConsumerStatefulWidget {
  const CommentTextField({
    super.key,
    required this.postId,
  });

  final String postId;

  @override
  ConsumerState<CommentTextField> createState() => _CommentTextFieldState();
}

class _CommentTextFieldState extends ConsumerState<CommentTextField> {
  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> makeComment() async {
    // make a comment
    final text = controller.text.trim();
    controller.clear();
    await ref.read(feedProvider).makeComment(
          text: text,
          postId: widget.postId,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.white,
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.only(
          left: 15,
        ),
        decoration: BoxDecoration(
          color: AppColors.greyColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Write your comment',
            border: InputBorder.none,
            suffixIcon: IconButton(
              onPressed: makeComment,
              icon: const Icon(Icons.send),
            ),
          ),
        ),
      ),
    );
  }
}
