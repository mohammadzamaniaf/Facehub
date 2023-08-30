import 'package:facehub/features/story/models/story.dart';
import 'package:flutter/material.dart';

class StoryTile extends StatelessWidget {
  const StoryTile({
    super.key,
    required this.story,
  });

  final Story story;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          width: 100,
          child: Image.network(
            story.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
