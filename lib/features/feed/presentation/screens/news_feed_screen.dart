import 'package:facehub/features/feed/presentation/widgets/stories_view.dart';
import 'package:flutter/material.dart';

import '/features/feed/presentation/widgets/feed_make_post_widget.dart';

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('News Feed Screen rebuilt');
    return Column(
      children: [
        // What's on your mind
        FeedMakePostWidget(),
        SizedBox(height: 8),

        // Stories
        const StoriesView(),
        const SizedBox(height: 8),
        Container(
          height: 100,
          color: Colors.white,
        ),
      ],
    );
  }
}
