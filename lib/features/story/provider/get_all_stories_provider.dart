import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/core/constants/firebase_collection_names.dart';
import '/core/constants/firebase_field_names.dart';
import '/features/auth/providers/get_user_info_provider.dart';
import '/features/story/models/story.dart';

final getAllStoriesProvider =
    StreamProvider.autoDispose<Iterable<Story>>((ref) {
  final userData = ref.watch(getUserInfoProvider);
  final controller = StreamController<Iterable<Story>>();

  userData.whenData((user) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    final myFriends = [
      ...user.friends,
      user.uid,
    ];

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionNames.stories)
        .orderBy(FirebaseFieldNames.createdAt, descending: true)
        .where(
          FirebaseFieldNames.createdAt,
          isGreaterThan: yesterday.millisecondsSinceEpoch,
        )
        .where(FirebaseFieldNames.authorId, whereIn: myFriends)
        .snapshots()
        .listen((snapshot) {
      final stories = snapshot.docs.map(
        (storyData) => Story.fromMap(
          storyData.data(),
        ),
      );
      controller.sink.add(stories);
    });

    ref.onDispose(() {
      controller.close();
      sub.cancel();
    });
  });

  return controller.stream;
});
