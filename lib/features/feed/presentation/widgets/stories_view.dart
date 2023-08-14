import 'package:flutter/material.dart';

import '/core/constants/app_colors.dart';
import '/core/constants/constants.dart';

class StoriesView extends StatelessWidget {
  const StoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    // https://picsum.photos/200/300?random=$number
    return Container(
      color: Colors.white,
      height: 200,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const CreateStoryWidget();
          }

          return StoryWidget(
            index: index,
          );
        },
      ),
    );
  }
}

class CreateStoryWidget extends StatelessWidget {
  const CreateStoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: AppColors.darkWhiteColor,
          height: 180,
          width: 100,
          child: Stack(
            children: [
              SizedBox(
                height: 120,
                width: 120,
                child: Image.network(
                  Constants.profilePicBlank,
                  fit: BoxFit.fitHeight,
                ),
              ),
              const Positioned(
                top: 100,
                left: 10,
                right: 10,
                child: CircleAvatar(
                  radius: 16,
                  child: Icon(Icons.add),
                ),
              ),
              const Positioned(
                left: 10,
                right: 10,
                bottom: 5,
                child: Column(
                  children: [
                    Text('Create'),
                    Text('Story'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StoryWidget extends StatelessWidget {
  const StoryWidget({
    super.key,
    required this.index,
  });

  final int index;

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
            'https://picsum.photos/200/300?random=$index',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
