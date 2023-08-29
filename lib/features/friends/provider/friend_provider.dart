import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/features/friends/repository/friend_repository.dart';

final friendProvider = Provider((ref) {
  return FriendRepository();
});
