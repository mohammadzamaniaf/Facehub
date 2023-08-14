import 'package:flutter/material.dart';

import '/features/feed/presentation/screens/news_feed_screen.dart';

class Constants {
  static const String maleProfilePic =
      'https://jeremyveldman.com/wp-content/uploads/2019/08/Generic-Profile-Pic.jpg';

  static const String profilePicBlank =
      'https://t3.ftcdn.net/jpg/05/16/27/58/240_F_516275801_f3Fsp17x6HQK0xQgDQEELoTuERO4SsWV.jpg';

  static List<Tab> getHomeScreenTabs(int index) {
    return [
      Tab(
        icon: Icon(
          index == 0 ? Icons.home : Icons.home_outlined,
          color: Colors.blue,
        ),
      ),
      Tab(
        icon: Icon(
          index == 1 ? Icons.group : Icons.group_outlined,
          color: Colors.blue,
        ),
      ),
      Tab(
        icon: Icon(
          index == 2 ? Icons.smart_display : Icons.smart_display_outlined,
          color: Colors.blue,
        ),
      ),
      Tab(
        icon: Icon(
          index == 3 ? Icons.account_circle : Icons.account_circle_outlined,
          color: Colors.blue,
        ),
      ),
      Tab(
        icon: Icon(
          index == 4 ? Icons.notifications : Icons.notifications_outlined,
          color: Colors.blue,
        ),
      ),
      Tab(
        icon: Icon(
          index == 5 ? Icons.density_medium : Icons.density_medium_outlined,
          color: Colors.blue,
        ),
      ),
    ];
  }

  static const homeScreenTabBarChildren = [
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
  ];

  Constants._();
}
