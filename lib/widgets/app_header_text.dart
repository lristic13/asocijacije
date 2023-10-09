import 'package:flutter/material.dart';

import '../constants/app_strings.dart';
import '../constants/app_styles.dart';

class AppTitleText extends StatelessWidget {
  const AppTitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.asocijacije,
          style: AppStyles.text50WhiteBold,
        ),
        Text(
          '.',
          style: AppStyles.text50CoralBold,
        ),
      ],
    );
  }
}
