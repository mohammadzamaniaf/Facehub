import 'package:facehub/features/friends/provider/friend_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/core/screens/error_screen.dart';
import '/core/screens/loader.dart';
import '/features/auth/presentation/widgets/round_button.dart';
import '/features/auth/providers/get_user_info_by_user_id_provider.dart';
import '/features/friends/provider/get_all_requests_provider.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: Text('Friend Requests')),
          RequestsList(),
          SliverToBoxAdapter(child: Text('Friends')),
          // FriendsList(),
        ],
      ),
    );
  }
}

class RequestsList extends ConsumerStatefulWidget {
  const RequestsList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RequestsListState();
}

class _RequestsListState extends ConsumerState<RequestsList> {
  @override
  Widget build(BuildContext context) {
    final requestsData = ref.watch(getAllRequestsProvider);
    return requestsData.when(
      data: (requests) {
        return SliverList.builder(
          itemCount: requests.length,
          itemBuilder: (context, index) {
            final userId = requests.elementAt(index);
            return FriendRequestTile(
              userId: userId,
            );
          },
        );
      },
      error: (error, stackTrace) {
        return SliverToBoxAdapter(
          child: ErrorScreen(
            error: error.toString(),
          ),
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

class FriendRequestTile extends ConsumerWidget {
  const FriendRequestTile({
    super.key,
    required this.userId,
  });

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(getUserInfoByUserIdProvider(userId));
    return userData.when(
      data: (user) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(user.profilePicUrl),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.fullName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: RoundButton(
                            onPressed: () async {
                              await ref
                                  .read(friendProvider)
                                  .acceptFriendRequest(userId: userId);
                            },
                            label: 'Accept',
                            height: 30,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: RoundButton(
                            onPressed: () async {
                              await ref
                                  .read(friendProvider)
                                  .removeFriendRequest(userId: userId);
                            },
                            label: 'Reject',
                            height: 30,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
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
}
