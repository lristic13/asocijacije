import 'package:asoscijacije_nove/constants/app_styles.dart';
import 'package:asoscijacije_nove/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'buttons/base-buttons/app_button_empty.dart';
import 'buttons/base-buttons/app_button_full.dart';

class AppAlertDialog extends StatelessWidget {
  const AppAlertDialog({
    required this.title,
    required this.content,
    required this.onPressedNo,
    required this.onPressedYes,
    super.key,
  });

  final String title;
  final String content;
  final void Function() onPressedNo;
  final void Function() onPressedYes;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        color: AppColors.englishVioletDarker,
      ),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppStyles.text25WhiteBold),
            const SizedBox(height: 5),
            Text(content, style: const TextStyle(color: AppColors.white)),
            const SizedBox(height: 15),
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
                    fillColor: AppColors.coral,
                    textColor: AppColors.englishVioletDarker,
                    buttonText: AppLocalizations.of(context)!.da,
                    onPressed: onPressedYes,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
