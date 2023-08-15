import 'package:facehub/config/routes/routes.dart';
import 'package:facehub/config/themes/app_theme.dart';
import 'package:facehub/core/screens/error_screen.dart';
import 'package:facehub/features/auth/presentation/screens/create_account_screen.dart';
import 'package:facehub/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';

import '/core/screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.appTheme(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.onGenerateRoute,
      home: const LoginScreen(),
    );
  }
}
