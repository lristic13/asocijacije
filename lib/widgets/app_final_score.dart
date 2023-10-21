import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../constants/app_colors.dart';
import '../constants/app_routes.dart';
import '../constants/app_styles.dart';
import '../models/team.dart';
import '../providers/all_providers.dart';
import '../util/boxes.dart';
import 'buttons/base-buttons/app_button_full.dart';

class AppFinalScore extends ConsumerWidget {
  const AppFinalScore({required this.box, super.key});

  final Box<Team> box;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.krajIgre,
              style: AppStyles.text50WhiteBold,
            ),
            const Text(
              '.',
              style: AppStyles.text50CoralBold,
            ),
          ],
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Text(
              '${AppLocalizations.of(context)!.pobednikJeTim} ${Boxes.getWinnerTeam(box).substring(Boxes.getWinnerTeam(box).length - 1)}!',
              style: AppStyles.text25CoralBold,
            ),
          ),
        ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          height: 60,
          child: AppButtonFull(
            fillColor: AppColors.coral,
            textColor: AppColors.englishViolet,
            buttonText: AppLocalizations.of(context)!.novaIgra,
            onPressed: () {
              ref.read(gameAdminProvider).resetGame();
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.homePage, (route) => false);
            },
          ),
        ),
      ],
    );
  }
}
