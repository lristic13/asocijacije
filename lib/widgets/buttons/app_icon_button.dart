import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({required this.onButtonPressed, super.key});

  final Function() onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onButtonPressed,
      icon: const Icon(Icons.info_outline, color: AppColors.white),
    );
  }
}
