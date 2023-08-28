import 'package:flutter/material.dart';

import '/features/post/presentation/widgets/comment_text_field.dart';
import '/features/post/presentation/widgets/comments_list.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({
    super.key,
    required this.postId,
  });

  final String postId;

  static const routeName = '/comments';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: Column(
        children: [
          // comments
          CommentsList(
            postId: postId,
          ),
          // comment text field
          CommentTextField(
            postId: postId,
          ),
        ],
      ),
    );
  }
}
