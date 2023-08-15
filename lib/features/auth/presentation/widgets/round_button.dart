import 'package:facehub/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.color = AppColors.lightBlueColor,
  });

  final VoidCallback onPressed;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: AppColors.darkBlueColor,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: color == AppColors.lightBlueColor
                  ? AppColors.realWhiteColor
                  : AppColors.darkBlueColor,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
