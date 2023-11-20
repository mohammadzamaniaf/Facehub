import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/core/constants/app_colors.dart';
import '/core/constants/constants.dart';
import '/core/constants/extensions.dart';
import '/core/screens/error_screen.dart';
import '/core/screens/loader.dart';
import '/core/widgets/add_friend_button.dart';
import '/core/widgets/icon_text_button.dart';
import '/features/auth/presentation/widgets/round_button.dart';
import '/features/auth/providers/get_user_info_as_stream_provider.dart';
import '/features/chat/presentation/screens/chat_screen.dart';
import '/features/story/presentation/screens/create_story_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({
    Key? key,
    this.userId,
  }) : super(key: key);

  final String? userId;

  static const routeName = '/profile';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myUserId = FirebaseAuth.instance.currentUser!.uid;
    final uid = userId ?? myUserId;
    final userInfo = ref.watch(
      getUserInfoAsStreamProvider(uid),
    );
    return userInfo.when(
      data: (user) {
        final isMyProfile = user.uid == myUserId;
        return SafeArea(
          child: Scaffold(
            appBar: user.uid != myUserId
                ? AppBar(
                    title: const Text('Profile'),
                  )
                : null,
            backgroundColor: AppColors.realWhiteColor,
            body: Padding(
              padding: Constants.defaultPadding,
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
                  isMyProfile
                      ? _buildAddToStoryButotn(context)
                      : AddFriendButton(user: user),
                  const SizedBox(height: 20),
                  // Chat Button
                  isMyProfile
                      ? const SizedBox()
                      : RoundButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              ChatScreen.routeName,
                              arguments: {
                                'userId': user.uid,
                              },
                            );
                          },
                          label: 'Send Message',
                          color: Colors.transparent,
                        ),
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

  // Story Button
  Widget _buildAddToStoryButotn(BuildContext context) => RoundButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            CreateStoryScreen.routeName,
          );
        },
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
            label: birthDay.yMMMEd(),
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
