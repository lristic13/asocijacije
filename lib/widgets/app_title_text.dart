import 'package:asoscijacije_nove/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../constants/app_styles.dart';

class AppTitleText extends StatelessWidget {
  const AppTitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)!.asocijacije,
          style: AppStyles.text50WhiteBold,
        ),
        const Text('.', style: AppStyles.text50CoralBold),
      ],
    );
  }
}
