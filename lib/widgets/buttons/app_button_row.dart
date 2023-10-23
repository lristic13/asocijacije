import 'package:asoscijacije_nove/constants/app_colors.dart';
import 'package:asoscijacije_nove/widgets/buttons/base-buttons/app_button_empty.dart';
import 'package:asoscijacije_nove/widgets/buttons/base-buttons/app_button_full.dart';
import 'package:flutter/material.dart';

class AppButtonRow extends StatelessWidget {
  const AppButtonRow(
      {required this.leftButtonText,
      required this.rightButtonText,
      required this.leftButtonCb,
      required this.rightButtonCb,
      super.key});

  final String leftButtonText;
  final String rightButtonText;
  final Function()? leftButtonCb;
  final Function()? rightButtonCb;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppButtonEmpty(
            buttonText: leftButtonText,
            borderColor: AppColors.white,
            textColor: AppColors.white,
            onPressed: leftButtonCb,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: AppButtonFull(
            buttonText: rightButtonText,
            fillColor: AppColors.coral,
            textColor: AppColors.englishVioletDarker,
            onPressed: rightButtonCb,
          ),
        ),
      ],
    );
  }
}
