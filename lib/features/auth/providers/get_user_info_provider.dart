import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/core/constants/firebase_collection_names.dart';
import '/features/auth/models/user.dart';

final getUserInfoProvider = FutureProvider<UserModel>(
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

// final getUserInfoProvider = StreamProvider.autoDispose<UserModel>(
//   (ref) {
//     final userId = FirebaseAuth.instance.currentUser!.uid;

//     final controller = StreamController<UserModel>();

//     final sub = FirebaseFirestore.instance
//         .collection(FirebaseCollectionNames.users)
//         .where(FirebaseFieldNames.uid, isEqualTo: userId)
//         .limit(1)
//         .snapshots()
//         .listen(
//       (snapshot) {
//         if (snapshot.docs.isNotEmpty) {
//           final userData = snapshot.docs.first;
//           final userModel = UserModel.fromMap(
//             userData.data(),
//           );
//           controller.sink.add(userModel);
//         }
//       },
//     );

//     ref.onDispose(() {
//       sub.cancel();
//       controller.close();
//     });

//     return controller.stream;
//   },
// );
