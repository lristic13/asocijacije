import 'package:asocijacije_nove/constants/app_colors.dart';
import 'package:asocijacije_nove/constants/app_styles.dart';
import 'package:flutter/material.dart';

class InstructionItem extends StatelessWidget {
  const InstructionItem({
    required this.titleText,
    required this.bodyText,
    super.key,
  });

  final String titleText;
  final String bodyText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleText,
          style: NeonText.display(size: 18, color: AppColors.orange),
        ),
        const SizedBox(height: 2),
        Text(
          bodyText,
          style: NeonText.body(
            size: 14,
            weight: FontWeight.w600,
            color: AppColors.sub,
          ),
        ),
      ],
    );
  }
}
