import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '/core/constants/firebase_collection_names.dart';
import '/features/post/models/comment.dart';
import '/features/post/models/post.dart';

class PostRepository {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  // make post
  Future<String?> makePost({
    required String content,
    required File file,
    required String postType,
  }) async {
    try {
      final postId = const Uuid().v1();
      final posterId = _auth.currentUser!.uid;
      final now = DateTime.now();

      // Post the image/video to storage
      final fileUid = const Uuid().v4();
      final path = _storage.ref(postType).child(fileUid);
      final taskSnapshot = await path.putFile(file);
      final downloadUrl = await taskSnapshot.ref.getDownloadURL();

      // create post object
      Post post = Post(
        postType: postType,
        postId: postId,
        posterId: posterId,
        content: content,
        fileUrl: downloadUrl,
        datePublished: now,
        likes: [],
      );

      // Save post to firestore
      _firestore
          .collection(FirebaseCollectionNames.posts)
          .doc(postId)
          .set(post.toMap());

      // no error caught
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // Like a post
  Future<String?> likeDislikePost({
    required String postId,
    required List<String> likes,
  }) async {
    try {
      final authorId = _auth.currentUser!.uid;

      if (likes.contains(authorId)) {
        // if we already liked the post, unlike it
        _firestore
            .collection(FirebaseCollectionNames.posts)
            .doc(postId)
            .update({
          FirebaseCollectionNames.likes: FieldValue.arrayRemove(
            [authorId],
          )
        });
      } else {
        // if we haven't liked the post, we like it
        _firestore
            .collection(FirebaseCollectionNames.posts)
            .doc(postId)
            .update({
          FirebaseCollectionNames.likes: FieldValue.arrayUnion(
            [authorId],
          )
        });
      }
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // Post a comment
  Future<String?> makeComment({
    required String text,
    required String postId,
  }) async {
    try {
      // get properties
      final authorId = _auth.currentUser!.uid;
      final commentId = const Uuid().v1();
      final now = DateTime.now();

      // create my comment object
      Comment comment = Comment(
        commentId: commentId,
        authorId: authorId,
        postId: postId,
        text: text,
        createdAt: now,
        likes: const [],
      );

      // Post comment to firebase
      await _firestore
          .collection(FirebaseCollectionNames.comments)
          .doc(commentId)
          .set(
            comment.toMap(),
          );

      return null;
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }

  // Like or dislike a comment
  Future<String?> likeDislikeComment({
    required String commentId,
    required List<String> likes,
  }) async {
    try {
      final authorId = _auth.currentUser!.uid;

      if (likes.contains(authorId)) {
        // if we already liked the post, unlike it
        _firestore
            .collection(FirebaseCollectionNames.comments)
            .doc(commentId)
            .update({
          FirebaseCollectionNames.likes: FieldValue.arrayRemove(
            [authorId],
          )
        });
      } else {
        // if we haven't liked the post, we like it
        _firestore
            .collection(FirebaseCollectionNames.comments)
            .doc(commentId)
            .update({
          FirebaseCollectionNames.likes: FieldValue.arrayUnion(
            [authorId],
          )
        });
      }
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
