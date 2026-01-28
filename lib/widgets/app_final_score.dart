import 'package:asoscijacije_nove/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants/app_colors.dart';
import '../constants/app_styles.dart';
import '../models/team.dart';
import '../providers/all_providers.dart';
import '../services/navigation_service.dart';
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
            const Text('.', style: AppStyles.text50CoralBold),
          ],
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Text(
              '${AppLocalizations.of(context)!.pobednikJeTim} ${Boxes.getWinnerTeam(box)?.teamName ?? '?'}!',
              style: AppStyles.text25CoralBold,
            ),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 25.0),
          child: AppButtonFull(
            fillColor: AppColors.coral,
            textColor: AppColors.englishViolet,
            buttonText: AppLocalizations.of(context)!.novaIgra,
            onPressed: () {
              ref
                  .read(gameAdminProvider.notifier)
                  .update((state) => state.resetGame());
              NavigationService.goToHome();
            },
          ),
        ),
      ],
    );
  }
}
