import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/features/auth/repository/auth_repository.dart';

final authProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(),
);
