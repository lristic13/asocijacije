import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class AppButtonFull extends StatelessWidget {
  const AppButtonFull(
      {required this.fillColor,
      required this.textColor,
      required this.onPressed,
      required this.buttonText,
      super.key});

  final Color? fillColor;
  final Color? textColor;
  final String? buttonText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          )),
          backgroundColor: MaterialStateProperty.all<Color>(
              fillColor ?? AppColors.englishVioletDarker)),
      onPressed: onPressed,
      child: Text(
        buttonText ?? '',
        style: TextStyle(
            color: textColor ?? AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20),
      ),
    );
  }
}
