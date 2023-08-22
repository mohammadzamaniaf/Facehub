import 'package:facehub/features/auth/presentation/screens/verify_email_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/core/constants/app_colors.dart';
import '/core/constants/paddings.dart';
import '/core/utils/utils.dart';
import '/features/auth/models/user.dart';
import '/features/auth/presentation/widgets/birthday_picker.dart';
import '/features/auth/presentation/widgets/gender_picker.dart';
import '/features/auth/presentation/widgets/round_button.dart';
import '/features/auth/presentation/widgets/round_text_field.dart';
import '/features/auth/providers/auth_providers.dart';
import '/features/auth/utils/validators.dart';

final _formKey = GlobalKey<FormState>();

class CreateAccountScreen extends ConsumerStatefulWidget {
  const CreateAccountScreen({super.key});

  static const routeName = '/create-account';

  @override
  ConsumerState<CreateAccountScreen> createState() =>
      _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {
  bool isLoading = false;

  DateTime? _birthDay;
  String? gender = 'male';
  late final TextEditingController _emailController;
  late final TextEditingController _fNameController;
  late final TextEditingController _lNameController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _fNameController = TextEditingController();
    _lNameController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _fNameController.dispose();
    _lNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.realWhiteColor,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: Paddings.defaultPadding,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    // First Name Text Field
                    Expanded(
                      child: RoundTextField(
                        controller: _fNameController,
                        hintText: 'First name',
                        textInputAction: TextInputAction.next,
                        validator: validateName,
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Last Name Text Field
                    Expanded(
                      child: RoundTextField(
                        controller: _lNameController,
                        hintText: 'Last name',
                        textInputAction: TextInputAction.next,
                        validator: validateName,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Birthday picker
                BirthdayPicker(
                  onPressed: () async {
                    _birthDay = await pickSimpleDate(
                          context: context,
                          date: _birthDay,
                        ) ??
                        DateTime.now();
                    setState(() {});
                  },
                  dateTime: _birthDay ?? DateTime.now(),
                ),
                const SizedBox(height: 20),
                // Gender Picker
                GenderPicker(
                  gender: gender,
                  onChanged: (value) {
                    gender = value;
                    setState(() {});
                  },
                ),
                const SizedBox(height: 20),
                // Phone number / email text field
                RoundTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  validator: validateEmail,
                ),
                const SizedBox(height: 20),
                // Password Text Field
                RoundTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                  validator: validatePassword,
                  isPassword: true,
                ),
                const SizedBox(height: 20),
                // Next Button
                isLoading
                    ? const CircularProgressIndicator()
                    : RoundButton(
                        onPressed: createAccount,
                        label: 'Next',
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> createAccount() async {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      final authRepo = ref.read(authProvider);

      // Create a user
      final user = UserModel(
        fullName: '${_fNameController.text} ${_lNameController.text}',
        birthDay: _birthDay ?? DateTime.now(),
        gender: gender!,
        email: _emailController.text,
        password: _passwordController.text,
        profilePicUrl: 'profilePicUrl',
      );

      // create account
      await authRepo.createAccount(user: user).then((credential) {
        if (credential!.user!.emailVerified == false) {
          // Navigator.of(context).pushNamed(
          //   VerifyEmailScreen.routeName,
          //   arguments: user.email,
          // );
        }
      }).catchError((_) {
        setState(() => isLoading = false);
      });
      setState(() => isLoading = false);
    }
  }
}
