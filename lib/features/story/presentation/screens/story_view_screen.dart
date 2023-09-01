import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

import '/features/story/models/story.dart';

class StoryViewScreen extends StatefulWidget {
  const StoryViewScreen({
    super.key,
    required this.stories,
  });

  final List<Story> stories;

  static const routeName = '/story_view';

  @override
  State<StoryViewScreen> createState() => _StoryViewScreenState();
}

class _StoryViewScreenState extends State<StoryViewScreen> {
  final controller = StoryController();

  final List<StoryItem> storyItems = [];

  @override
  void initState() {
    super.initState();
    for (final story in widget.stories) {
      final storyView = StoryItem.pageImage(
        url: story.imageUrl,
        controller: controller,
      );
      storyItems.add(storyView);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoryView(
      onStoryShow: (storyItem) {},
      controller: controller,
      storyItems: storyItems,
      onComplete: Navigator.of(context).pop,
      onVerticalSwipeComplete: Navigator.of(context).pop,
    );
  }
}
