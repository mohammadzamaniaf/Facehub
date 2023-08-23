import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '/core/constants/firebase_collection_names.dart';
import '/core/constants/firebase_field_names.dart';
import '/core/constants/storage_folder_names.dart';
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
          likesCount: 0,
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

  Stream<List<Post>> getAllPosts() {
    return _firestore
        .collection(FirebaseCollectionNames.posts)
        .orderBy(FirebaseFieldNames.datePublished, descending: true)
        .snapshots()
        .asyncMap(
          (querySnapshot) => querySnapshot.docs
              .map(
                (post) => Post.fromMap(
                  post.data(),
                ),
              )
              .toList(),
        );
  }
}
