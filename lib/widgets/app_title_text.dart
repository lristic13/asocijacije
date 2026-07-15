import 'package:asocijacije_nove/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_styles.dart';

/// Brand wordmark — "Asocijacije" in Fredoka with a glowing orange period,
/// over a soft orange bloom.
class AppTitleText extends StatelessWidget {
  const AppTitleText({this.size = 54, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    final base = NeonText.display(
      size: size,
      color: AppColors.ink,
      letterSpacing: -1.5,
      height: 1,
      shadows: NeonText.glow(AppColors.orange, blur: 28, opacity: 0.55),
    );
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: AppLocalizations.of(context)!.asocijacije,
        style: base,
        children: [
          TextSpan(text: '.', style: base.copyWith(color: AppColors.orange)),
        ],
      ),
    );
  }
}
