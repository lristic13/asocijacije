import 'package:asoscijacije_nove/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppTwoPointsLabel extends StatelessWidget {
  const AppTwoPointsLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: AppColors.coral,
      ),
      child: const Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 4),
        child: Text(
          '+2 POENA',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.englishVioletDarker,
          ),
        ),
      ),
    );
  }
}
