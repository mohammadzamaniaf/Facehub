import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/core/screens/profile_screen.dart';
import '/features/auth/providers/get_user_info_provider.dart';

class MyProfilePic extends ConsumerWidget {
  const MyProfilePic({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(getUserInfoProvider);

    return userInfo.when(
      data: (user) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProfileScreen.routeName,
              arguments: user.uid,
            );
          },
          child: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(user.profilePicUrl),
          ),
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
