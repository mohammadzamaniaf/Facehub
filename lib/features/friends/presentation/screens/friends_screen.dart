import 'package:flutter/material.dart';

import '/core/constants/paddings.dart';
import '/features/friends/presentation/widgets/friends_list.dart';
import '/features/friends/presentation/widgets/requests_list.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: Paddings.defaultPadding,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Text(
                'Friend Requests',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            RequestsList(),
            SliverToBoxAdapter(
              child: Divider(
                height: 50,
                thickness: 3,
                color: Colors.black,
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                'Friends',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            FriendsList(),
          ],
        ),
      ),
    );
  }
}
