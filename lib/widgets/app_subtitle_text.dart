import 'package:asocijacije_nove/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../constants/app_styles.dart';

class AppSubtitleText extends StatelessWidget {
  const AppSubtitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppLocalizations.of(context)!.saPapiricaUApp,
        style: AppStyles.text20CoralBold,
      ),
    );
  }
}
