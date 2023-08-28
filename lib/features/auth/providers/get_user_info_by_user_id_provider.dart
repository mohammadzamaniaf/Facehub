import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/core/constants/firebase_collection_names.dart';
import '/features/auth/models/user.dart';

final getUserInfoByUserIdProvider =
    FutureProvider.autoDispose.family<UserModel, String?>(
  (
    ref,
    String? userId,
  ) {
    return FirebaseFirestore.instance
        .collection(FirebaseCollectionNames.users)
        .doc(userId)
        .get()
        .then(
          (userData) => UserModel.fromMap(userData.data()!),
        );
  },
);
