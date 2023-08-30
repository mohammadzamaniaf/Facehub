import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/features/story/repository/story_repository.dart';

final storyProvider = Provider((ref) {
  return StoryRepository();
});
