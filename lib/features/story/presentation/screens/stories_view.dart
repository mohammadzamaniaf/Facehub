import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/core/screens/loader.dart';
import '/features/story/presentation/screens/story_view_screen.dart';
import '/features/story/presentation/widgets/create_story_widget.dart';
import '/features/story/presentation/widgets/story_tile.dart';
import '/features/story/provider/get_all_stories_provider.dart';

class StoriesView extends ConsumerWidget {
  const StoriesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storyData = ref.watch(getAllStoriesProvider);

    return storyData.when(
      data: (stories) {
        return SliverToBoxAdapter(
          child: Container(
            color: Colors.white,
            height: 200,
            child: ListView.builder(
              itemCount: stories.length + 1,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                if (index == 0) {
                  // Add Story button
                  return const CreateStoryWidget();
                }

                final story = stories.elementAt(index - 1);

                // Story Tile
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      StoryViewScreen.routeName,
                      arguments: stories.toList(),
                    );
                  },
                  child: StoryTile(
                    story: story,
                  ),
                );
              },
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return SliverToBoxAdapter(
          child: Text(
            error.toString(),
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
