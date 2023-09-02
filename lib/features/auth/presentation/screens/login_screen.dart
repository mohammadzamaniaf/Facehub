import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/core/constants/constants.dart';
import '/features/auth/presentation/screens/create_account_screen.dart';
import '/features/auth/presentation/widgets/round_button.dart';
import '/features/auth/presentation/widgets/round_text_field.dart';
import '/features/auth/providers/auth_providers.dart';
import '/features/auth/utils/validators.dart';

final _formKey = GlobalKey<FormState>();

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  bool isLoading = false;

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

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() => isLoading = true);
      await ref.read(authProvider).signIn(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: Constants.defaultPadding,
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
            Form(
              key: _formKey,
              child: Column(
                children: [
                  RoundTextField(
                    controller: _emailController,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: validateEmail,
                  ),
                  const SizedBox(height: 15),
                  RoundTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    isPassword: true,
                    validator: validatePassword,
                  ),
                  const SizedBox(height: 15),
                  // Login Button
                  isLoading
                      ? const CircularProgressIndicator()
                      : RoundButton(
                          onPressed: login,
                          label: 'Login',
                        ),
                  const SizedBox(height: 15),
                  const Text(
                    'Forgot Password?',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
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
