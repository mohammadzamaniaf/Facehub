import 'package:facehub/core/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/features/auth/providers/auth_providers.dart';

class VerifyEmailScreen extends ConsumerWidget {
  static const routeName = '/verify-email-screen';

  const VerifyEmailScreen({
    super.key,
    required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              await ref.read(authProvider).verifyEmail().then(
                (result) {
                  if (result == null) {
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text('Email verification sent to $email'),
                        ),
                      );
                  }
                },
              );
            },
            child: const Text('Verify Email'),
          ),
          const SizedBox(height: 20, width: double.infinity),
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.currentUser!.reload();
              final emailVerified =
                  FirebaseAuth.instance.currentUser?.emailVerified;
              if (emailVerified == true) {
                Navigator.of(context).pushNamed(HomeScreen.routeName);
              }
            },
            child: const Text('Refresh'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await ref.read(authProvider).signOut();
            },
            child: const Text('Change Email'),
          ),
        ],
      ),
    );
  }
}
