import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facehub/features/auth/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/core/constants/firebase_collection_names.dart';
import '/core/constants/firebase_field_names.dart';
import '/features/story/models/story.dart';

final getAllStoriesProvider =
    StreamProvider.autoDispose<Iterable<Story>>((ref) {
  final myUid = FirebaseAuth.instance.currentUser!.uid;
  List<String> myFriends = [myUid];

  final yesterday = DateTime.now().subtract(const Duration(days: 1));

  FirebaseFirestore.instance
      .collection(FirebaseCollectionNames.users)
      .doc(myUid)
      .get()
      .then((userData) {
    final user = UserModel.fromMap(userData.data()!);
    myFriends = user.friends;
  });

  final controller = StreamController<Iterable<Story>>();

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

  return controller.stream;
});
