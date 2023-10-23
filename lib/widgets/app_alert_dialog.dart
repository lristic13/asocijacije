import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../constants/app_colors.dart';
import 'buttons/base-buttons/app_button_empty.dart';
import 'buttons/base-buttons/app_button_full.dart';

class AppAlertDialog extends StatelessWidget {
  const AppAlertDialog(
      {required this.title,
      required this.content,
      required this.onPressedNo,
      required this.onPressedYes,
      super.key});

  final String title;
  final String content;
  final void Function() onPressedNo;
  final void Function() onPressedYes;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.englishVioletLighter,
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        content,
        style: const TextStyle(color: AppColors.white),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: AppButtonEmpty(
                borderColor: AppColors.white,
                textColor: AppColors.white,
                buttonText: AppLocalizations.of(context)!.ne,
                onPressed: onPressedNo,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AppButtonFull(
                  fillColor: AppColors.englishVioletDarker,
                  textColor: AppColors.white,
                  buttonText: AppLocalizations.of(context)!.da,
                  onPressed: onPressedYes),
            ),
          ],
        ),
      ],
    );
  }
}
