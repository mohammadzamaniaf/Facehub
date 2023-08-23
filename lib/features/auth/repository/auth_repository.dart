import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facehub/core/constants/firebase_field_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '/core/constants/firebase_collection_names.dart';
import '/core/constants/storage_folder_names.dart';
import '/core/utils/utils.dart';
import '/features/auth/models/user.dart';

@immutable
class AuthRepository {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  String? get userId => _auth.currentUser?.uid;
  bool? get emailVerified => _auth.currentUser?.emailVerified;

  // Sign out
  Future<String?> signOut() async {
    try {
      await _auth.signOut();
      return null;
    } on FirebaseAuthException catch (e) {
      showToastMessage(text: e.toString());
      return e.toString();
    } catch (e) {
      showToastMessage(text: e.toString());
      return e.toString();
    }
  }

  // Sign in
  Future<UserCredential?> signIn({
    required email,
    required String password,
  }) async {
    try {
      // login using email and password
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential;
    } catch (e) {
      showToastMessage(text: e.toString());
      return null;
    }
  }

  // Create an account
  Future<UserCredential?> createAccount({
    required String fullName,
    required DateTime birthDay,
    required String gender,
    required String email,
    required String password,
    required File? image,
  }) async {
    try {
      // create an account in firebase
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save image to storage and get download url
      final path = _storage.ref(StorageFolderNames.profilePics).child(userId!);
      if (image == null) {
        return null;
      }
      final taskSnapshot = await path.putFile(image);
      final downloadUrl = await taskSnapshot.ref.getDownloadURL();

      // create user
      UserModel user = UserModel(
        fullName: fullName,
        birthDay: birthDay,
        gender: gender,
        email: email,
        password: password,
        profilePicUrl: downloadUrl,
        uid: userId!,
        friends: [],
        sentRequests: [],
        receivedRequests: [],
      );

      // save user to firebase
      await _firestore
          .collection(FirebaseCollectionNames.users)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(user.toMap());

      return credential;
    } catch (e) {
      showToastMessage(text: e.toString());
      return null;
    }
  }

  // Verify email
  Future<String?> verifyEmail() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        await user.sendEmailVerification();
        return null;
      } catch (e) {
        showToastMessage(text: e.toString());
        return e.toString();
      }
    }
    return 'Email does not exist';
  }

  Future<UserModel> getUserInfo() async {
    final userData = await _firestore
        .collection(FirebaseCollectionNames.users)
        .doc(userId)
        .get();

    final user = UserModel.fromMap(userData.data()!);
    return user;
  }
}
