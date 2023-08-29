import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable;

import '/core/constants/firebase_collection_names.dart';
import '/core/constants/firebase_field_names.dart';

@immutable
class FriendRepository {
  final _myUid = FirebaseAuth.instance.currentUser!.uid;
  final _firestore = FirebaseFirestore.instance;

  // Send friend request
  Future<String?> sendFriendRequest({
    required String userId,
  }) async {
    try {
      // Add your uid to other person's received requests
      await _firestore
          .collection(FirebaseCollectionNames.users)
          .doc(userId)
          .update({
        FirebaseFieldNames.receivedRequests: FieldValue.arrayUnion(
          [_myUid],
        )
      });

      // Add other person's uid to your sent requests
      await _firestore
          .collection(FirebaseCollectionNames.users)
          .doc(_myUid)
          .update({
        FirebaseFieldNames.sentRequests: FieldValue.arrayUnion(
          [userId],
        )
      });
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // Accept friend request
  Future<String?> acceptFriendRequest({
    required String userId,
  }) async {
    try {
      // Add other person's uid to your list of friends
      await _firestore
          .collection(FirebaseCollectionNames.users)
          .doc(_myUid)
          .update({
        FirebaseFieldNames.friends: FieldValue.arrayUnion(
          [userId],
        ),
      });

      // Add your uid to other person's list of friends
      await _firestore
          .collection(FirebaseCollectionNames.users)
          .doc(userId)
          .update({
        FirebaseFieldNames.friends: FieldValue.arrayUnion(
          [_myUid],
        ),
      });

      // Remove Requests
      removeFriendRequest(userId: userId);

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // Reject Friend Request
  Future<String?> removeFriendRequest({
    required String userId,
  }) async {
    try {
      // Remove other person's user id from received requests
      await _firestore
          .collection(FirebaseCollectionNames.users)
          .doc(_myUid)
          .update({
        FirebaseFieldNames.receivedRequests: FieldValue.arrayRemove(
          [userId],
        ),
      });

      // Remove my user id from other person's sent requests
      await _firestore
          .collection(FirebaseCollectionNames.users)
          .doc(userId)
          .update({
        FirebaseFieldNames.sentRequests: FieldValue.arrayRemove(
          [_myUid],
        ),
      });

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // Remove a friend
  Future<String?> removeFriend({
    required String userId,
  }) async {
    try {
      // Remove other person's uid from your list of friends
      await _firestore
          .collection(FirebaseCollectionNames.users)
          .doc(_myUid)
          .update({
        FirebaseFieldNames.friends: FieldValue.arrayRemove(
          [userId],
        ),
      });

      // Remove your uid from other person's list of friends
      await _firestore
          .collection(FirebaseCollectionNames.users)
          .doc(userId)
          .update({
        FirebaseFieldNames.friends: FieldValue.arrayRemove(
          [_myUid],
        ),
      });

      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
