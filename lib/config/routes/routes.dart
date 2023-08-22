import 'package:facehub/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/core/screens/error_screen.dart';
import '/features/auth/presentation/screens/create_account_screen.dart';
import '/features/auth/presentation/screens/verify_email_screen.dart';

class Routes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CreateAccountScreen.routeName:
        return _cupertinoRoute(const CreateAccountScreen());
      case VerifyEmailScreen.routeName:
        final email = settings.arguments as String;
        return _cupertinoRoute(
          VerifyEmailScreen(
            email: email,
          ),
        );
      case LoginScreen.routeName:
        return _cupertinoRoute(
          const LoginScreen(),
        );

      default:
        return _materialRoute(
          ErrorScreen(error: 'Wrong Route provided ${settings.name}'),
        );
    }
  }

  // Build material routes for views
  static Route _materialRoute(Widget view) => MaterialPageRoute(
        builder: (_) => view,
      );

  static Route _cupertinoRoute(Widget view) => CupertinoPageRoute(
        builder: (_) => view,
      );

  Routes._();
}
