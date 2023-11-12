import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/core/constants/firebase_collection_names.dart';
import '/core/constants/firebase_field_names.dart';
import '/features/chat/models/message.dart';

/// This provider will get all the messages for a specific chatroom
/// The message are by default stored in a sub-collection inside the
/// chatroom document.
final getAllMessagesProvider = StreamProvider.family
    .autoDispose<Iterable<Message>, String>((ref, String chatroomId) {
  final myUid = FirebaseAuth.instance.currentUser!.uid;
  final controller = StreamController<Iterable<Message>>();

  final messages = FirebaseFirestore.instance
      .collection(FirebaseCollectionNames.chatrooms)
      .doc(chatroomId)
      .collection(FirebaseCollectionNames.messages);

  final sub = messages
      .orderBy(FirebaseFieldNames.timestamp, descending: true)
      .snapshots()
      .listen((snapshots) {
    final messages = snapshots.docs.map(
      (messageData) => Message.fromMap(messageData.data()),
    );
    controller.sink.add(messages);
  });

  ref.onDispose(() {
    controller.close();
    sub.cancel();
  });

  return controller.stream;
});
