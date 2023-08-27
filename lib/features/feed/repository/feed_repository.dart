import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '/core/constants/firebase_collection_names.dart';
import '/core/constants/storage_folder_names.dart';
import '/features/feed/models/comment.dart';
import '/features/feed/models/post.dart';

class FeedRepository {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  // make post
  Future<String?> makePost({
    required String content,
    required List<File> images,
  }) async {
    try {
      final postId = const Uuid().v1();
      final posterId = _auth.currentUser!.uid;
      final now = DateTime.now();

      List<String> imageUrls = [];

      // Post all images to storage and get download urls
      for (var image in images) {
        final imageUid = const Uuid().v4();
        final path = _storage.ref(StorageFolderNames.photos).child(imageUid);
        final taskSnapshot = await path.putFile(image);
        final downloadUrl = await taskSnapshot.ref.getDownloadURL();
        imageUrls.add(downloadUrl);

        // create post object
        Post post = Post(
          postId: postId,
          posterId: posterId,
          content: content,
          imageUrls: imageUrls,
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
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
    return null;
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
