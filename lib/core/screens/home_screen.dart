import 'package:flutter/material.dart';

import '/core/constants/app_colors.dart';
import '/core/constants/constants.dart';
import '/features/feed/presentation/screens/news_feed_screen.dart';
import '/features/feed/presentation/widgets/messenger_widget.dart';
import '/features/feed/presentation/widgets/search_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: buildFacebookText(),
          actions: const [
            SearchWidget(),
            MessengerWidget(),
          ],
          bottom: const TabBar(
            tabs: FeedConstants.homeScreenAppBarTabs,
          ),
        ),
        body: const TabBarView(
          children: [
            NewsFeedScreen(),
            Center(
              child: Text('Friends'),
            ),
            Center(
              child: Text('Videos'),
            ),
            Center(
              child: Text('Profile'),
            ),
            Center(
              child: Text('Notifications'),
            ),
            Center(
              child: Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildFacebookText() => const Text(
      'facebook',
      style: TextStyle(
        fontSize: 30,
        color: AppColors.blueColor,
        fontWeight: FontWeight.bold,
      ),
    );
