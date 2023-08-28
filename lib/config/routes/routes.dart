import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/core/screens/error_screen.dart';
import '/core/screens/home_screen.dart';
import '/features/auth/presentation/screens/create_account_screen.dart';
import '/features/auth/presentation/screens/login_screen.dart';
import '/features/auth/presentation/screens/verify_email_screen.dart';
import '/features/post/presentation/screens/comments_screen.dart';
import '/features/post/presentation/screens/create_post_screen.dart';
import '/features/profile/presentation/screens/profile_screen.dart';

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
      case HomeScreen.routeName:
        return _cupertinoRoute(
          const HomeScreen(),
        );
      case CreatePostScreen.routeName:
        return _cupertinoRoute(
          const CreatePostScreen(),
        );
      case CommentsScreen.routeName:
        final postId = settings.arguments as String;
        return _cupertinoRoute(
          CommentsScreen(
            postId: postId,
          ),
        );
      case ProfileScreen.routeName:
        final userId = settings.arguments as String;
        return _cupertinoRoute(
          ProfileScreen(
            userId: userId,
          ),
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
