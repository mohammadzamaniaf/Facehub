import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/core/constants/firebase_collection_names.dart';
import '/core/constants/firebase_field_names.dart';
import '/features/auth/models/user.dart';

final getAllFriendsProvider = StreamProvider.autoDispose<Iterable<String>>(
  (ref) {
    final myUid = FirebaseAuth.instance.currentUser!.uid;

    final controller = StreamController<Iterable<String>>();

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionNames.users)
        .where(FirebaseFieldNames.uid, isEqualTo: myUid)
        .limit(1)
        .snapshots()
        .listen((snapshot) {
      final userData = snapshot.docs.first.data();
      final friends = UserModel.fromMap(userData).friends;
      controller.sink.add(friends);
    });

    ref.onDispose(() {
      controller.close();
      sub.cancel();
    });

    return controller.stream;
  },
);
