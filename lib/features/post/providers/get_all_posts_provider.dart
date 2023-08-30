import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/core/constants/firebase_collection_names.dart';
import '/core/constants/firebase_field_names.dart';
import '/features/post/models/post.dart';

final getAllPostsProvider = StreamProvider.autoDispose<Iterable<Post>>(
  (ref) {
    final controller = StreamController<Iterable<Post>>();

    final sub = FirebaseFirestore.instance
        .collection(
          FirebaseCollectionNames.posts,
        )
        .orderBy(
          FirebaseFieldNames.datePublished,
          descending: true,
        )
        .snapshots()
        .listen(
      (snapshots) {
        final posts = snapshots.docs.map(
          (postData) => Post.fromMap(
            postData.data(),
          ),
        );
        controller.sink.add(posts);
      },
    );

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
