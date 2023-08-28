import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';

import '/core/constants/app_colors.dart';
import '/core/constants/paddings.dart';
import '/core/screens/error_screen.dart';
import '/core/screens/loader.dart';
import '/core/widgets/icon_text_button.dart';
import '/features/auth/presentation/widgets/round_button.dart';
import '/features/auth/providers/get_user_info_by_user_id_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({
    super.key,
    required this.userId,
  });

  final String userId;

  static const routeName = '/profile';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myUserId = FirebaseAuth.instance.currentUser!.uid;
    final userInfo = ref.watch(getUserInfoByUserIdProvider(userId));
    return userInfo.when(
      data: (user) {
        return SafeArea(
          child: Scaffold(
            appBar: user.uid != myUserId
                ? AppBar(
                    title: const Text('Profile'),
                  )
                : null,
            backgroundColor: AppColors.realWhiteColor,
            body: Padding(
              padding: Paddings.defaultPadding,
              child: Column(
                children: [
                  // profile pic
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user.profilePicUrl),
                  ),
                  const SizedBox(height: 10),
                  // display name
                  Text(
                    user.fullName,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // profile button
                  userId == myUserId
                      ? _buildAddToStoryButotn()
                      : _buildAddFriendButton(),
                  const SizedBox(height: 20),
                  // User Profile Info
                  _buildProfileInfo(
                    gender: user.gender,
                    birthDay: user.birthDay,
                    email: user.email,
                  ),
                ],
              ),
            ),
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

  Widget _buildAddFriendButton() => RoundButton(
        onPressed: () {},
        label: 'Add Friend',
      );

  Widget _buildAddToStoryButotn() => RoundButton(
        onPressed: () {},
        label: 'Add to Story',
      );

  Widget _buildProfileInfo({
    required String gender,
    required DateTime birthDay,
    required String email,
  }) =>
      Column(
        children: [
          IconTextButton(
            icon: gender == 'male' ? Icons.male : Icons.female,
            label: gender,
          ),
          const SizedBox(height: 10),
          IconTextButton(
            icon: Icons.cake,
            label: Jiffy.parseFromDateTime(birthDay).yMMMEd,
          ),
          const SizedBox(height: 10),
          IconTextButton(
            icon: Icons.email,
            label: email,
          ),
          const SizedBox(height: 10),
        ],
      );
}
