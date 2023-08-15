import 'package:flutter/material.dart';

class VerifyOTPScreen extends StatelessWidget {
  const VerifyOTPScreen({super.key});

  static const routeName = '/verify-otp-screen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Verify OTP Screen'),
      ),
    );
  }
}
