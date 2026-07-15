import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';

/// Circular "i" info button — a hairline ring in the muted [AppColors.sub].
class AppIconButton extends StatelessWidget {
  const AppIconButton({required this.onButtonPressed, super.key});

  final Function() onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonPressed,
      child: Container(
        width: 30,
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.sub, width: 1.5),
        ),
        child: Text(
          'i',
          style: NeonText.body(
            size: 14,
            weight: FontWeight.w700,
            color: AppColors.sub,
          ),
        ),
      ),
    );
  }
}
