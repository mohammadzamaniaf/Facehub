// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

import '/core/constants/app_colors.dart';
import '/core/constants/paddings.dart';
import '/features/auth/presentation/widgets/gender_radio_tile.dart';

class GenderPicker extends StatelessWidget {
  const GenderPicker({
    Key? key,
    required this.gender,
    required this.onChanged,
  }) : super(key: key);

  final String? gender;
  final Function(String? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Paddings.defaultPadding,
      decoration: BoxDecoration(
        color: AppColors.darkWhiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          GenderRadioTile(
            title: 'Male',
            value: 'male',
            selectedValue: gender,
            onChanged: onChanged,
          ),
          GenderRadioTile(
            title: 'Female',
            value: 'female',
            selectedValue: gender,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
