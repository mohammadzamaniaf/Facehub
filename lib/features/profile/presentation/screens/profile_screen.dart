// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:facehub/features/auth/providers/get_user_info_as_stream_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';

import '/core/constants/app_colors.dart';
import '/core/constants/paddings.dart';
import '/core/screens/error_screen.dart';
import '/core/screens/loader.dart';
import '/core/widgets/icon_text_button.dart';
import '/features/auth/models/user.dart';
import '/features/auth/presentation/widgets/round_button.dart';
import '/features/friends/provider/friend_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({
    Key? key,
    this.userId,
  }) : super(key: key);

  final String? userId;

  static const routeName = '/profile';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = userId ?? FirebaseAuth.instance.currentUser!.uid;
    final myUserId = FirebaseAuth.instance.currentUser!.uid;
    final userInfo = ref.watch(getUserInfoAsStreamProvider(uid));
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
                      : AddFriendButton(user: user),
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

class AddFriendButton extends ConsumerStatefulWidget {
  const AddFriendButton({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  ConsumerState<AddFriendButton> createState() => _AddFriendButtonState();
}

class _AddFriendButtonState extends ConsumerState<AddFriendButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final myUid = FirebaseAuth.instance.currentUser!.uid;
    final requestSent = widget.user.receivedRequests.contains(myUid);
    final alreadyFriend = widget.user.friends.contains(myUid);
    return isLoading
        ? const Loader()
        : RoundButton(
            onPressed: () async {
              final provider = ref.read(friendProvider);
              final userId = widget.user.uid;
              setState(() => isLoading = true);
              if (requestSent) {
                // cancel request
                provider.removeFriendRequest(userId: userId);
              } else if (alreadyFriend) {
                // remove friendship
                provider.removeFriend(userId: userId);
              } else {
                // sent friend request
                provider.sendFriendRequest(userId: userId);
              }
              setState(() => isLoading = false);
            },
            label: requestSent
                ? 'Cancel Request'
                : alreadyFriend
                    ? 'Remove Friend'
                    : 'Add Friend',
          );
  }
}
