import 'package:asoscijacije_nove/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        Column(
          children: [
            const SizedBox(height: 30),
            SvgPicture.asset(
              'assets/images/snowflake-regular.svg',
              colorFilter:
                  const ColorFilter.mode(AppColors.coral, BlendMode.srcIn),
              height: 20,
            ),
          ],
        ),
        // const Text(
        //   '.',
        //   style: AppStyles.text50CoralBold,
        // ),
      ],
    );
  }
}
