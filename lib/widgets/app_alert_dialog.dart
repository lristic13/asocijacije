import 'package:asocijacije_nove/constants/app_styles.dart';
import 'package:asocijacije_nove/l10n/app_localizations.dart';
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
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: AppColors.bg,
        border: Border(
          top: BorderSide(
            color: AppColors.orange.withValues(alpha: 0.4),
            width: 1.5,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: NeonText.display(size: 24, color: AppColors.ink),
              ),
              const SizedBox(height: 6),
              Text(
                content,
                style: NeonText.body(
                  size: 14,
                  weight: FontWeight.w500,
                  color: AppColors.sub,
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: AppButtonEmpty(
                      borderColor: AppColors.ink,
                      textColor: AppColors.ink,
                      buttonText: AppLocalizations.of(context)!.ne,
                      onPressed: onPressedNo,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: AppButtonFull(
                      fillColor: AppColors.orange,
                      textColor: AppColors.inkOnFill,
                      buttonText: AppLocalizations.of(context)!.da,
                      onPressed: onPressedYes,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
