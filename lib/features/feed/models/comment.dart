import 'package:facehub/core/constants/firebase_field_names.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class Comment {
  final String commentId;
  final String authorId;
  final String postId;
  final String text;
  final DateTime createdAt;
  final List<int> likes;

  const Comment({
    required this.commentId,
    required this.authorId,
    required this.postId,
    required this.text,
    required this.createdAt,
    required this.likes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      FirebaseFieldNames.commentId: commentId,
      FirebaseFieldNames.authorId: authorId,
      FirebaseFieldNames.postId: postId,
      FirebaseFieldNames.text: text,
      FirebaseFieldNames.createdAt: createdAt.millisecondsSinceEpoch,
      FirebaseFieldNames.likes: likes,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      commentId: map[FirebaseFieldNames.commentId] ?? '',
      authorId: map[FirebaseFieldNames.authorId] ?? '',
      postId: map[FirebaseFieldNames.postId] ?? '',
      text: map[FirebaseFieldNames.text] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        map[FirebaseFieldNames.createdAt] ?? 0,
      ),
      likes: List<int>.from(
        (map[FirebaseFieldNames.likes] ?? []),
      ),
    );
  }
}