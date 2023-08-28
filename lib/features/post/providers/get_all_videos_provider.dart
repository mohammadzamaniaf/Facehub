import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/core/constants/firebase_collection_names.dart';
import '/core/constants/firebase_field_names.dart';
import '/features/post/models/post.dart';

final getAllVideosProvider = StreamProvider.autoDispose<Iterable<Post>>(
  (ref) {
    final controller = StreamController<Iterable<Post>>();

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionNames.posts)
        .orderBy(FirebaseFieldNames.datePublished, descending: true)
        .where(FirebaseFieldNames.postType, isEqualTo: 'video')
        .snapshots()
        .listen(
      (snapshots) {
        final videos = snapshots.docs.map(
          (doc) => Post.fromMap(
            doc.data(),
          ),
        );
        controller.sink.add(videos);
      },
    );

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
