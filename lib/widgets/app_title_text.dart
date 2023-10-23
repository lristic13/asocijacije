import 'package:flutter/material.dart';

import '../constants/app_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        const Text(
          '.',
          style: AppStyles.text50CoralBold,
        ),
      ],
    );
  }
}
