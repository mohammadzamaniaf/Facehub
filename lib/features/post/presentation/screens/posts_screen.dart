import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/core/screens/error_screen.dart';
import '/core/screens/loader.dart';
import '/features/post/presentation/widgets/make_post_widget.dart';
import '/features/post/presentation/widgets/post_tile.dart';
import '/features/story/presentation/screens/stories_view.dart';
import '/features/post/providers/get_all_posts_provider.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        // What's on your mind
        FeedMakePostWidget(),
        SliverToBoxAdapter(child: SizedBox(height: 8)),

        // Stories
        StoriesView(),
        SliverToBoxAdapter(child: SizedBox(height: 8)),

        // Posts
        PostsList(),
      ],
    );
  }
}

class PostsList extends ConsumerWidget {
  const PostsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(getAllPostsProvider);

    return posts.when(
      data: (Iterable posts) {
        return SliverList.separated(
          itemCount: posts.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final post = posts.elementAt(index);
            return PostTile(
              post: post,
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
