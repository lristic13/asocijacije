import 'package:flutter/material.dart';
import '../constants/app_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppSubtitleText extends StatelessWidget {
  const AppSubtitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(AppLocalizations.of(context)!.saPapiricaUApp,
            style: AppStyles.text20CoralBold));
  }
}
