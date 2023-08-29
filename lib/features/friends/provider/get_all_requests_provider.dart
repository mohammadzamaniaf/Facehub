import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/core/constants/firebase_collection_names.dart';
import '/core/constants/firebase_field_names.dart';
import '/features/auth/models/user.dart';

final getAllRequestsProvider =
    StreamProvider.autoDispose<Iterable<String>>((ref) {
  final myUid = FirebaseAuth.instance.currentUser!.uid;

  final controller = StreamController<Iterable<String>>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionNames.users)
      .where(FirebaseFieldNames.uid, isEqualTo: myUid)
      .limit(1)
      .snapshots()
      .listen((doc) {
    final userData = doc.docs.first.data();
    final requests = UserModel.fromMap(userData).receivedRequests;
    controller.sink.add(requests);
  });

  ref.onDispose(() {
    controller.close();
    sub.cancel();
  });

  return controller.stream;
});
