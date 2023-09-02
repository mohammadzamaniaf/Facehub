import 'package:facehub/core/widgets/post_info_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

import '/features/story/models/story.dart';
import '/features/story/provider/story_provider.dart';

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
      final storyView = StoryItem(
        StoryDetailScreen(story: story),
        duration: const Duration(seconds: 5),
      );
      storyItems.add(storyView);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoryView(
      controller: controller,
      storyItems: storyItems,
      onComplete: Navigator.of(context).pop,
      onVerticalSwipeComplete: Navigator.of(context).pop,
      indicatorColor: Colors.black,
      indicatorForegroundColor: Colors.grey,
    );
  }
}

class StoryDetailScreen extends ConsumerStatefulWidget {
  const StoryDetailScreen({
    super.key,
    required this.story,
  });

  final Story story;

  @override
  ConsumerState<StoryDetailScreen> createState() => _StoryDetailScreenState();
}

class _StoryDetailScreenState extends ConsumerState<StoryDetailScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(storyProvider).viewStory(storyId: widget.story.storyId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: double.infinity,
              child: Image.network(
                widget.story.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // time posted
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: PostInfoTile(
              datePublished: widget.story.createdAt,
              userId: widget.story.authorId,
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Container(
              width: 100,
              height: 50,
              color: Colors.black54,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FaIcon(
                    FontAwesomeIcons.eye,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${widget.story.views.length}',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
