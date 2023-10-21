import 'package:asoscijacije_nove/constants/app_strings.dart';
import 'package:flutter/material.dart';

import '../constants/app_styles.dart';

class AppSubtitleText extends StatelessWidget {
  const AppSubtitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(AppStrings.saPapiricaUAplikaciju,
            style: AppStyles.text20CoralBold));
  }
}
