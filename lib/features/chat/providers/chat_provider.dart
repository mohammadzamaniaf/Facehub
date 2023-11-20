import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/features/chat/repository/chat_repository.dart';

final chatProvider = Provider((ref) {
  return ChatRepository();
});
