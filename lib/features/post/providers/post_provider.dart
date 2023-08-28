import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/features/post/repository/post_repository.dart';

final postProvider = Provider((ref) {
  return PostRepository();
});
