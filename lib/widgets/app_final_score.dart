import 'package:asocijacije_nove/l10n/app_localizations.dart';
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
        const Text('🏆', style: TextStyle(fontSize: 56)),
        const SizedBox(height: 14),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: AppLocalizations.of(context)!.krajIgre,
            style: NeonText.display(
              size: 44,
              color: AppColors.ink,
              shadows: NeonText.glow(AppColors.orange, blur: 28, opacity: 0.55),
            ),
            children: [
              TextSpan(
                text: '.',
                style: NeonText.display(size: 44, color: AppColors.orange),
              ),
            ],
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Text(
              '${AppLocalizations.of(context)!.pobednikJeTim} ${Boxes.getWinnerTeam(box)?.teamName ?? '?'}!',
              textAlign: TextAlign.center,
              style: NeonText.display(
                size: 22,
                color: AppColors.cyan,
                shadows: NeonText.glow(AppColors.cyan, blur: 22, opacity: 0.5),
              ),
            ),
          ),
        ),
        const Spacer(),

        Padding(
          padding: const EdgeInsets.only(bottom: 25.0),
          child: AppButtonFull(
            fillColor: AppColors.orange,
            textColor: AppColors.inkOnFill,
            buttonText: AppLocalizations.of(context)!.novaIgra,
            onPressed: () {
              ref
                  .read(gameAdminProvider.notifier)
                  .update((state) => state.resetGame());
              ref.read(customWordsProvider.notifier).update((state) => false);
              ref.read(customWordsListProvider.notifier).update((state) => []);
              NavigationService.goToHome();
            },
          ),
        ),
      ],
    );
  }
}
