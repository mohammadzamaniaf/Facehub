import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facehub/core/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';

import '/core/constants/firebase_collection_names.dart';
import '/features/auth/models/user.dart';

@immutable
class AuthRepository {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  String? get userId => _auth.currentUser?.uid;
  bool? get emailVerified => _auth.currentUser?.emailVerified;

  // Sign out
  Future<String?> signOut() async {
    try {
      await _auth.signOut();
      return null;
    } on FirebaseAuthException catch (e) {
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
  Future<String?> createAccount({
    required UserModel user,
  }) async {
    try {
      // create an account in firebase
      await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      // save data to firebase
      await _firestore
          .collection(FirebaseCollectionNames.users)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(user.toMap());

      return null;
    } catch (e) {
      showToastMessage(text: e.toString());
      return e.toString();
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
}
