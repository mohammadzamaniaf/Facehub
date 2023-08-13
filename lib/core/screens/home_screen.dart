import 'package:flutter/material.dart';

import '/core/constants/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Feed'),
          bottom: const TabBar(
            tabs: FeedConstants.homeScreenAppBarTabs,
          ),
        ),
        body: const TabBarView(
          children: [
            Center(
              child: Text('Feed'),
            ),
            Center(
              child: Text('Videos'),
            ),
            Center(
              child: Text('Community'),
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
