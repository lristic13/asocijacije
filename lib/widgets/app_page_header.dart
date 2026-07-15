import 'package:asocijacije_nove/constants/app_colors.dart';
import 'package:asocijacije_nove/constants/app_styles.dart';
import 'package:flutter/material.dart';

/// Screen title in the Neon Arcade style: Fredoka heading ending with an
/// orange period ".".
class AppPageHeader extends StatelessWidget {
  const AppPageHeader({required this.title, this.fontSize = 26, super.key});
  final String title;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: title,
        style: NeonText.display(size: fontSize, color: AppColors.ink),
        children: [
          TextSpan(
            text: '.',
            style: NeonText.display(size: fontSize, color: AppColors.orange),
          ),
        ],
      ),
    );
  }
}
