import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/core/screens/error_screen.dart';
import '/core/screens/loader.dart';
import '/features/auth/presentation/widgets/round_button.dart';
import '/features/auth/providers/get_user_info_by_user_id_provider.dart';
import '/features/friends/provider/friend_provider.dart';

class FriendTile extends ConsumerWidget {
  const FriendTile({
    super.key,
    required this.userId,
  });

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(getUserInfoByUserIdProvider(userId));
    return userData.when(
      data: (user) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(user.profilePicUrl),
              ),
              const SizedBox(width: 15),
              Text(
                user.fullName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        return ErrorScreen(error: error.toString());
      },
      loading: () {
        return const Loader();
      },
    );
  }
}