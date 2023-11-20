import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:uuid/uuid.dart';

import '/core/constants/firebase_collection_names.dart';
import '/core/constants/firebase_field_names.dart';
import '/features/chat/models/chatroom.dart';
import '/features/chat/models/message.dart';

@immutable
class ChatRepository {
  final _storage = FirebaseStorage.instance;
  final _myUid = FirebaseAuth.instance.currentUser!.uid;

  /// A function for creating a chatroom
  /// Returns id of the chat room if successful
  /// Return null if failed
  // Create a chat
  Future<String> createChatroom({
    required String userId,
  }) async {
    try {
      // Get chatroom collection reference
      CollectionReference chatrooms = FirebaseFirestore.instance
          .collection(FirebaseCollectionNames.chatrooms);

      // First sort both members
      final sortedMembers = [_myUid, userId]..sort((a, b) => a.compareTo(b));

      // Check if there's an existing chat room
      QuerySnapshot existingChatrooms = await chatrooms
          .where(
            FirebaseFieldNames.members,
            isEqualTo: sortedMembers,
          )
          .get();

      if (existingChatrooms.docs.isNotEmpty) {
        // If the chat room already exists, return its ID
        return existingChatrooms.docs.first.id;
      } else {
        final chatroomId = const Uuid().v1();

        // Create a new chat room document
        Chatroom chatroom = Chatroom(
          chatroomId: chatroomId,
          lastMessage: '',
          lastMessageTs: DateTime.now(),
          members: sortedMembers,
          createdAt: DateTime.now(),
        );

        await FirebaseFirestore.instance
            .collection(FirebaseCollectionNames.chatrooms)
            .doc(chatroomId)
            .set(chatroom.toMap());

        // Return the ID of the newly created chat room
        return chatroomId;
      }
    } catch (e) {
      return e.toString();
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
      final now = DateTime.now();

      // Create your message
      Message newMessage = Message(
        message: message,
        messageId: messageId,
        senderId: _myUid,
        receiverId: receiverId,
        timestamp: now,
        seen: false,
        messageType: 'text',
      );

      DocumentReference myChatroomRef = FirebaseFirestore.instance
          .collection(FirebaseCollectionNames.chatrooms)
          .doc(chatroomId);

      // Save message to firestore
      await myChatroomRef
          .collection(FirebaseCollectionNames.messages)
          .doc(messageId)
          .set(newMessage.toMap());

      // Update the last message
      await myChatroomRef.update({
        FirebaseFieldNames.lastMessage: message,
        FirebaseFieldNames.lastMessageTs: now.millisecondsSinceEpoch,
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
      final now = DateTime.now();

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
        timestamp: now,
        seen: false,
        messageType: messageType,
      );

      // Create message collection reference
      DocumentReference myChatroomRef = FirebaseFirestore.instance
          .collection(FirebaseCollectionNames.chatrooms)
          .doc(chatroomId);

      // Save message to firestore
      await myChatroomRef
          .collection(FirebaseCollectionNames.messages)
          .doc(messageId)
          .set(
            newMessage.toMap(),
          );

      // Update the last message
      await myChatroomRef.update({
        FirebaseFieldNames.lastMessage: 'sent a $messageType',
        FirebaseFieldNames.lastMessageTs: now.millisecondsSinceEpoch,
      });

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  /// Mark messages as seen in the firestore
  /// Returns null is successful
  /// Returns the error message in failed
  Future<String?> seenMessage({
    required String chatroomId,
    required String messageId,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionNames.chatrooms)
          .doc(chatroomId)
          .collection(FirebaseCollectionNames.messages)
          .doc(messageId)
          .update({
        FirebaseFieldNames.seen: true,
      });
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
