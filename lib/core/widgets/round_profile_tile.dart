import 'package:flutter/material.dart';

import '/core/constants/app_colors.dart';

class RoundProfileTile extends StatelessWidget {
  const RoundProfileTile({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: CircleAvatar(
        backgroundColor: AppColors.greyColor,
        radius: 20,
        backgroundImage: NetworkImage(url),
      ),
    );
  }
}
