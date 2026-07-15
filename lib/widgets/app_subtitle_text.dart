import 'package:asocijacije_nove/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_styles.dart';

/// Home tagline — "forget the paper, use the app!" in cyan Hanken.
class AppSubtitleText extends StatelessWidget {
  const AppSubtitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppLocalizations.of(context)!.saPapiricaUApp,
        textAlign: TextAlign.center,
        style: NeonText.body(
          size: 16.5,
          weight: FontWeight.w700,
          color: AppColors.cyan,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
