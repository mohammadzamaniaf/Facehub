import 'package:flutter/material.dart';

import '/core/constants/paddings.dart';
import '/features/auth/presentation/screens/create_account_screen.dart';
import '/features/auth/presentation/widgets/round_button.dart';
import '/features/auth/presentation/widgets/round_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.loginScreenColor,
      body: Padding(
        padding: Paddings.defaultPadding,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Facebook logo
            Image.asset(
              'assets/icons/fb_logo.png',
              width: 60,
            ),
            // Text Fields (Email and Password)
            Column(
              children: [
                RoundTextField(
                  controller: _emailController,
                  hintText: 'Mobile number or email',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 15),
                RoundTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  isPassword: true,
                ),
                const SizedBox(height: 15),
                // Login Button
                RoundButton(onPressed: () {}, label: 'Login'),
                const SizedBox(height: 15),
                const Text(
                  'Forgot Password?',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            // Bottom Part of Login Screen
            Column(
              children: [
                RoundButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      CreateAccountScreen.routeName,
                    );
                  },
                  label: 'Create new account',
                  color: Colors.transparent,
                ),
                Image.asset(
                  'assets/icons/meta.png',
                  height: 50,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
