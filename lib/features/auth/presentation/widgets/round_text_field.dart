// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class RoundTextField extends StatelessWidget {
  const RoundTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.keyboardType,
    required this.textInputAction,
    this.isPassword = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      obscureText: isPassword,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
    );
  }
}
