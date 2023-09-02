import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/core/constants/extensions.dart';
import '/core/screens/error_screen.dart';
import '/core/screens/loader.dart';
import '/core/screens/profile_screen.dart';
import '/features/auth/providers/get_user_info_by_user_id_provider.dart';

class PostInfoTile extends ConsumerWidget {
  const PostInfoTile({
    super.key,
    required this.datePublished,
    required this.userId,
  });

  final DateTime datePublished;
  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(getUserInfoByUserIdProvider(userId));

    return userInfo.when(
      data: (user) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    ProfileScreen.routeName,
                    arguments: user.uid,
                  );
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    user.profilePicUrl,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.fullName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    datePublished.fromNow(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.more_horiz),
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
