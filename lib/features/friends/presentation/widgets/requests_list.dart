import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/core/screens/error_screen.dart';
import '/core/screens/loader.dart';
import '/features/friends/presentation/widgets/friend_request_tile.dart';
import '/features/friends/provider/get_all_requests_provider.dart';

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
