import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/core/screens/error_screen.dart';
import '/core/screens/loader.dart';
import '/features/friends/presentation/widgets/friend_tile.dart';
import '/features/friends/provider/get_all_friends_provider.dart';

class FriendsList extends ConsumerWidget {
  const FriendsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friendsData = ref.watch(getAllFriendsProvider);
    return friendsData.when(
      data: (friends) {
        return SliverList.builder(
          itemCount: friends.length,
          itemBuilder: (context, index) {
            final userId = friends.elementAt(index);
            return FriendTile(
              userId: userId,
            );
          },
        );
      },
      error: (error, stackTrace) {
        return SliverToBoxAdapter(
          child: ErrorScreen(error: error.toString()),
        );
      },
      loading: () {
        return const SliverToBoxAdapter(
          child: Loader(),
        );
      },
    );
  }
}
