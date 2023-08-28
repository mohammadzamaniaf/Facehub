import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/core/constants/firebase_collection_names.dart';
import '/core/constants/firebase_field_names.dart';
import '/features/post/models/comment.dart';

final getAllCommentsProvider =
    StreamProvider.autoDispose.family<Iterable<Comment>, String>((ref, postId) {
  final controller = StreamController<Iterable<Comment>>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionNames.comments)
      .where(FirebaseFieldNames.postId, isEqualTo: postId)
      .orderBy(FirebaseFieldNames.createdAt, descending: true)
      .snapshots()
      .listen((event) {
    final comments = event.docs.map(
      (comment) => Comment.fromMap(
        comment.data(),
      ),
    );
    controller.sink.add(comments);
  });

  ref.onDispose(() {
    controller.close();
    sub.cancel();
  });

  return controller.stream;
});
