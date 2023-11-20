import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/features/auth/providers/get_user_info_by_user_id_provider.dart';

class RoundProfilePic extends ConsumerWidget {
  const RoundProfilePic({
    super.key,
    required this.userId,
    this.radius = 20,
  });

  final String userId;
  final double radius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(getUserInfoByUserIdProvider(userId));

    return userInfo.when(
      data: (user) {
        return CircleAvatar(
          radius: radius,
          backgroundImage: NetworkImage(user.profilePicUrl),
        );
      },
      error: (error, stackTrace) {
        return CircleAvatar(
          radius: 20,
          child: Text(error.toString()),
        );
      },
      loading: () {
        return const CircleAvatar(
          radius: 20,
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
