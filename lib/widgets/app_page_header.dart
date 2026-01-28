import 'package:asoscijacije_nove/constants/app_styles.dart';
import 'package:flutter/material.dart';

class AppPageHeader extends StatelessWidget {
  const AppPageHeader({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title, style: AppStyles.text30WhiteBold),
        const Text('.', style: AppStyles.text30CoralBold),
      ],
    );
  }
}
