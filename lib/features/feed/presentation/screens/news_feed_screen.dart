import 'package:flutter/material.dart';

import '../../data/models/post.dart';
import '/features/feed/presentation/widgets/feed_make_post_widget.dart';
import '/features/feed/presentation/widgets/post_tile.dart';
import '/features/feed/presentation/widgets/stories_view.dart';

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // What's on your mind
        const FeedMakePostWidget(),
        const SliverToBoxAdapter(child: SizedBox(height: 8)),

        // Stories
        const StoriesView(),
        const SliverToBoxAdapter(child: SizedBox(height: 8)),

        // Posts
        SliverList.separated(
          itemCount: fakePosts.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final post = fakePosts[index];
            return PostTile(
              post: post,
            );
          },
        ),
      ],
    );
  }
}
