import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/core/constants/app_colors.dart';
import '/core/constants/constants.dart';
import '/core/widgets/round_icon_button.dart';
import '/features/chat/presentation/widgets/chats_list.dart';
import '/features/chat/presentation/widgets/round_profile_pic.dart';
import '/features/story/presentation/screens/create_story_screen.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  static const routeName = '/chats';

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.realWhiteColor,
      body: SafeArea(
        child: Padding(
          padding: Constants.defaultPadding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Chat top part (profile pic + text)
                buildChatsAppBar(),

                const SizedBox(height: 20),

                // Search Bar
                buildChatsSearchBar(controller: _searchController),

                const SizedBox(height: 30),

                // Chats List
                const SizedBox(
                  height: 500,
                  child: ChatsList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildChatsAppBar() => Row(
        children: [
          const MyProfilePic(),
          const SizedBox(width: 5),
          const Text(
            'Chats',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          RoundIconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                CreateStoryScreen.routeName,
              );
            },
            icon: FontAwesomeIcons.camera,
          ),
        ],
      );

  Widget buildChatsSearchBar({
    required TextEditingController controller,
  }) =>
      Container(
        decoration: BoxDecoration(
          color: AppColors.greyColor.withOpacity(.5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 15),
            const Icon(Icons.search),
            const SizedBox(width: 15),
            Expanded(
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                  hintStyle: TextStyle(),
                ),
              ),
            ),
          ],
        ),
      );
}
