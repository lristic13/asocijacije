import 'package:asoscijacije_nove/l10n/app_localizations.dart';
import 'package:asoscijacije_nove/models/game_mode.dart';
import 'package:asoscijacije_nove/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/all_providers.dart';

mixin GameMixin {
  void roundEnd(BuildContext context, WidgetRef ref) {
    final currentState = ref.read(gameAdminProvider);

    if (currentState.teamPlaying == ref.read(playerNumberProvider) / 2) {
      if (currentState.playerExplaining == 2) {
        final newState = currentState.copyWith(
          playerExplaining: 1,
          roundInProgress: ref.read(wordsProvider).wordsToPlay.isEmpty
            ? currentState.roundInProgress + 1
            : currentState.roundInProgress,
          teamPlaying: 1,
        );
        ref.read(gameAdminProvider.notifier).update((state) => newState);
      } else {
        final newState = currentState.copyWith(
          playerExplaining: 2,
          teamPlaying: 1,
        );
        ref.read(gameAdminProvider.notifier).update((state) => newState);
      }
    } else {
      final newState = currentState.copyWith(
        teamPlaying: currentState.teamPlaying + 1,
      );
      ref.read(gameAdminProvider.notifier).update((state) => newState);
    }

    ref.read(wordsProvider).wordsToPlay.shuffle();
    ref.read(blurProvider.notifier).update((state) => true);

    NavigationService.goToScoreboard();
  }

  void allWordsGuessed(BuildContext context, WidgetRef ref) {
    final currentState = ref.read(gameAdminProvider);
    final newState = currentState.copyWith(
      playerExplaining: 1,
      teamPlaying: 1,
      roundInProgress: currentState.roundInProgress + 1,
    );
    ref.read(gameAdminProvider.notifier).update((state) => newState);

    ref.read(wordsProvider).refreshWords();

    NavigationService.goToScoreboard();
  }

  String getRoundTitle(WidgetRef ref, BuildContext context) {
    if (ref.read(gameAdminProvider).roundInProgress == 1) {
      return AppLocalizations.of(context)!.normalnaRunda;
    } else if (ref.read(gameAdminProvider).roundInProgress == 2) {
      return AppLocalizations.of(context)!.jednaRecRunda;
    }
    return AppLocalizations.of(context)!.pantomimaRunda;
  }

  int calculateRoundTime(WidgetRef ref) {
    final isNormal = ref.read(gameModeProvider) == GameMode.normal;
    final isRound3 = ref.read(gameAdminProvider).roundInProgress == 3;

    if (isNormal) {
      return isRound3
          ? GameMode.normalRound3Duration
          : GameMode.normalRound1And2Duration;
    } else {
      return isRound3
          ? GameMode.quickRound3Duration
          : GameMode.quickRound1And2Duration;
    }
  }
}
