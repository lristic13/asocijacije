import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../constants/app_routes.dart';
import '../providers/all_providers.dart';

mixin GameMixin {
  void roundEnd(BuildContext context, WidgetRef ref) {
    if (ref.read(gameAdminProvider.notifier).state.teamPlaying ==
        ref.read(playerNumberProvider) / 2) {
      if (ref.read(gameAdminProvider).playerExplaining == 2) {
        ref.read(gameAdminProvider.notifier).state.playerExplaining = 1;
        if (ref.read(wordsProvider).wordsToPlay.isEmpty) {
          ref.read(gameAdminProvider.notifier).state.roundInProgress++;
        }
      } else {
        ref.read(gameAdminProvider.notifier).state.playerExplaining = 2;
      }
      ref.read(gameAdminProvider.notifier).state.teamPlaying = 1;
    } else {
      ref.read(gameAdminProvider.notifier).state.teamPlaying++;
    }

    Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.scoreboardPage, (route) => false);
  }

  void allWordsGuessed(BuildContext context, WidgetRef ref) {
    ref.read(gameAdminProvider.notifier).state.playerExplaining = 1;
    ref.read(gameAdminProvider.notifier).state.teamPlaying = 1;
    ref.read(gameAdminProvider.notifier).state.roundInProgress++;

    ref.read(wordsProvider).refreshWords();

    Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.scoreboardPage, (route) => false);
  }

  String getRoundTitle(WidgetRef ref, BuildContext context) {
    if (ref.read(gameAdminProvider).roundInProgress == 1) {
      return AppLocalizations.of(context)!.normalnaRunda;
    } else if (ref.read(gameAdminProvider).roundInProgress == 2) {
      return AppLocalizations.of(context)!.jednaRecRunda;
    }
    return AppLocalizations.of(context)!.pantomimaRunda;
  }
}
