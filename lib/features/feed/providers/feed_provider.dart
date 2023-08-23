import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/features/feed/repository/feed_repository.dart';

final feedProvider = Provider((ref) {
  return FeedRepository();
});
