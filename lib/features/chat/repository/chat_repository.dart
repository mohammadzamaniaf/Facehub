import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facehub/core/constants/firebase_collection_names.dart';
import 'package:facehub/core/constants/firebase_field_names.dart';
import 'package:facehub/features/chat/models/chatroom.dart';
import 'package:facehub/features/chat/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:uuid/uuid.dart';

@immutable
class ChatRepository {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  final _myUid = FirebaseAuth.instance.currentUser!.uid;

  /// A function for creating a chatroom
  /// Returns id of the chat room if successful
  /// Return null if failed
  // Create a chat
  Future<String?> createChatroom({
    required String userId,
  }) async {
    try {
      // Get chatroom collection reference
      CollectionReference chatrooms = FirebaseFirestore.instance
          .collection(FirebaseCollectionNames.chatrooms);

      // Check if there's an existing chat room
      QuerySnapshot existingChatrooms = await chatrooms.where(
        FirebaseFieldNames.members,
        arrayContains: [_myUid, userId],
      ).get();

      if (existingChatrooms.docs.isNotEmpty) {
        // If the chat room already exists, return its ID
        return existingChatrooms.docs.first.id;
      } else {
        final chatroomId = const Uuid().v1();
        // Create a new chat room document
        Chatroom chatroom = Chatroom(
          chatroomId: chatroomId,
          lastMessage: null,
          lastMessageTs: null,
          members: [_myUid, userId],
          createdAt: DateTime.now(),
        );

        DocumentReference newChatroom = await chatrooms.add({
          chatroom.toMap(),
        });

        // Return the ID of the newly created chat room
        return newChatroom.id;
      }
    } catch (e) {
      return null;
    }
  }

  // Send a message
  Future<String?> sendMessage({
    required String message,
    required String chatroomId,
    required String receiverId,
  }) async {
    try {
      // Create message Id
      final messageId = const Uuid().v1();

      // Create your message
      Message newMessage = Message(
        message: message,
        messageId: messageId,
        senderId: _myUid,
        receiverId: receiverId,
        timestamp: DateTime.now(),
        seen: false,
        messageType: 'text',
      );

      CollectionReference messagesRef = FirebaseFirestore.instance
          .collection(FirebaseCollectionNames.chatrooms)
          .doc(chatroomId)
          .collection(FirebaseCollectionNames.messages);

      // Save message to firestore
      await messagesRef.add({
        newMessage.toMap(),
      });

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // Send a file (image/video)
  // Send a message
  Future<String?> sendFileMessage({
    required File file,
    required String chatroomId,
    required String receiverId,
    required String messageType,
  }) async {
    try {
      // Create message Id
      final messageId = const Uuid().v1();

      // Save file to storage
      Reference ref = _storage.ref(messageType).child(messageId);
      TaskSnapshot snapshot = await ref.putFile(file);
      final downloadUrl = await snapshot.ref.getDownloadURL();

      // Create your message
      Message newMessage = Message(
        message: downloadUrl,
        messageId: messageId,
        senderId: _myUid,
        receiverId: receiverId,
        timestamp: DateTime.now(),
        seen: false,
        messageType: messageType,
      );

      // Create message collection reference
      CollectionReference messagesRef = FirebaseFirestore.instance
          .collection(FirebaseCollectionNames.chatrooms)
          .doc(chatroomId)
          .collection(FirebaseCollectionNames.messages);

      // Save message to firestore
      await messagesRef.add({
        newMessage.toMap(),
      });

      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
