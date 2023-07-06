import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class AppButtonEmpty extends StatelessWidget {
  const AppButtonEmpty(
      {required this.borderColor,
      required this.textColor,
      required this.buttonText,
      required this.onPressed,
      this.textSize,
      super.key});

  final Color? borderColor;

  final Color? textColor;
  final void Function()? onPressed;
  final String? buttonText;
  final double? textSize;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            side: BorderSide(color: borderColor ?? AppColors.white, width: 3),
            borderRadius: BorderRadius.circular(13),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        buttonText ?? '',
        style: TextStyle(
            color: textColor ?? AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: textSize ?? 20),
      ),
    );
  }
}
