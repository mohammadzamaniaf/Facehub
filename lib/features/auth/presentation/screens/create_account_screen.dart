import 'package:facehub/features/auth/presentation/screens/verify_email_screen.dart';
import 'package:facehub/features/auth/presentation/screens/verify_otp_screen.dart';
import 'package:flutter/material.dart';

import '/core/constants/app_colors.dart';
import '/core/constants/paddings.dart';
import '/core/constants/utils/utils.dart';
import '/features/auth/presentation/widgets/birthday_picker.dart';
import '/features/auth/presentation/widgets/gender_picker.dart';
import '/features/auth/presentation/widgets/round_button.dart';
import '/features/auth/presentation/widgets/round_text_field.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  static const routeName = '/create-account';

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  DateTime? _birthDay;
  String? gender;
  bool useEmail = false;
  late final TextEditingController _emailController;
  late final TextEditingController _fNameController;
  late final TextEditingController _lNameController;
  late final TextEditingController _birthdayController;
  late final TextEditingController _phoneNumberController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _fNameController = TextEditingController();
    _lNameController = TextEditingController();
    _birthdayController = TextEditingController();
    _phoneNumberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _fNameController.dispose();
    _lNameController.dispose();
    _birthdayController.dispose();
    _phoneNumberController.dispose();
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
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Last Name Text Field
                  Expanded(
                    child: RoundTextField(
                      controller: _lNameController,
                      hintText: 'Last name',
                      textInputAction: TextInputAction.next,
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
              useEmail
                  ? RoundTextField(
                      controller: _emailController,
                      hintText: 'Email',
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.emailAddress,
                    )
                  : RoundTextField(
                      controller: _phoneNumberController,
                      hintText: 'Mobile Number',
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.phone,
                    ),
              const SizedBox(height: 20),
              RoundButton(
                onPressed: () {
                  useEmail = !useEmail;
                  setState(() {});
                },
                label: useEmail
                    ? 'Sign up with phone number'
                    : 'Sign up with email',
                color: Colors.transparent,
              ),
              const SizedBox(height: 20),
              // Next Button
              RoundButton(
                onPressed: () {
                  if (useEmail) {
                    // Go to verify email screen
                    Navigator.of(context).pushNamed(
                      VerifyEmailScreen.routeName,
                    );
                  } else {
                    // Go to verify otp screen
                    Navigator.of(context).pushNamed(
                      VerifyOTPScreen.routeName,
                    );
                  }
                },
                label: 'Next',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
