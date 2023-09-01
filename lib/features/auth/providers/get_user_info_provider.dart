import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/core/constants/firebase_collection_names.dart';
import '/features/auth/models/user.dart';

final getUserInfoProvider = FutureProvider.autoDispose<UserModel>(
  (ref) {
    return FirebaseFirestore.instance
        .collection(FirebaseCollectionNames.users)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
          (userData) => UserModel.fromMap(userData.data()!),
        );
  },
);
