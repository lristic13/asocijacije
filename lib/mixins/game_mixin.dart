import 'package:asocijacije_nove/l10n/app_localizations.dart';
import 'package:asocijacije_nove/models/game_mode.dart';
import 'package:asocijacije_nove/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/all_providers.dart';

mixin GameMixin {
  void roundEnd(BuildContext context, WidgetRef ref) {
    final currentState = ref.read(gameAdminProvider);

    // Handle 1v1 mode differently
    if (currentState.is1v1Mode) {
      _roundEnd1v1(context, ref);
      return;
    }

    if (currentState.teamPlaying == ref.read(playerNumberProvider) / 2) {
      if (currentState.playerExplaining == 2) {
        // Only rotate here — the round advance is owned solely by
        // [allWordsGuessed] (triggered from the scoreboard when the pool is
        // empty). Incrementing here too double-counted the round whenever the
        // pool happened to empty on the last team's Player 2, skipping a round.
        final newState = currentState.copyWith(
          playerExplaining: 1,
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

  void _roundEnd1v1(BuildContext context, WidgetRef ref) {
    // Switch to the other player
    ref.read(oneVsOneProvider.notifier).update(
          (state) => state.switchPlayer(),
        );

    ref.read(wordsProvider).wordsToPlay.shuffle();
    ref.read(blurProvider.notifier).update((state) => true);

    // Navigate to 1v1 scoreboard
    NavigationService.goTo1v1Scoreboard(ref);
  }

  void allWordsGuessed(BuildContext context, WidgetRef ref) {
    final currentState = ref.read(gameAdminProvider);

    // Handle 1v1 mode differently
    if (currentState.is1v1Mode) {
      _allWordsGuessed1v1(context, ref);
      return;
    }

    final totalTeams = ref.read(playerNumberProvider) ~/ 2;

    // Calculate next team/player in rotation
    int nextTeam;
    int nextPlayer;

    if (currentState.teamPlaying == totalTeams) {
      // Last team played, go to first team
      nextTeam = 1;
      if (currentState.playerExplaining == 2) {
        // P2 was explaining, go back to P1
        nextPlayer = 1;
      } else {
        // P1 was explaining, go to P2
        nextPlayer = 2;
      }
    } else {
      // Not the last team, go to next team, same player
      nextTeam = currentState.teamPlaying + 1;
      nextPlayer = currentState.playerExplaining;
    }

    // Advance round AND move to next team/player in rotation
    final newState = currentState.copyWith(
      roundInProgress: currentState.roundInProgress + 1,
      teamPlaying: nextTeam,
      playerExplaining: nextPlayer,
    );
    ref.read(gameAdminProvider.notifier).update((state) => newState);

    ref.read(wordsProvider).refreshWords();

    NavigationService.goToScoreboard();
  }

  void _allWordsGuessed1v1(BuildContext context, WidgetRef ref) {
    final currentState = ref.read(gameAdminProvider);
    final newRound = currentState.roundInProgress + 1;

    // Check if game is over (round 4 = final)
    if (newRound >= GameMode.finalRound) {
      // Game over - navigate to results
      NavigationService.goToOneVsOneResults();
      return;
    }

    // Switch to the other player (next in rotation)
    ref.read(oneVsOneProvider.notifier).update(
          (state) => state.switchPlayer(),
        );

    // Advance to next round
    final newState = currentState.copyWith(
      roundInProgress: newRound,
    );
    ref.read(gameAdminProvider.notifier).update((state) => newState);

    ref.read(wordsProvider).refreshWords();

    NavigationService.goTo1v1Scoreboard(ref);
  }

  String getRoundTitle(WidgetRef ref, BuildContext context) {
    if (ref.read(gameAdminProvider).roundInProgress == 1) {
      return AppLocalizations.of(context)!.normalnaRunda;
    } else if (ref.read(gameAdminProvider).roundInProgress == 2) {
      return AppLocalizations.of(context)!.jednaRecRunda;
    }
    return AppLocalizations.of(context)!.pantomimaRunda;
  }

  int getDoublePointsThreshold(WidgetRef ref) {
    final isNormal = ref.read(gameModeProvider) == GameMode.normal;
    final isRound3 = ref.read(gameAdminProvider).roundInProgress == 3;

    if (isNormal) {
      return isRound3
          ? GameMode.normalMimeDoublePointsThreshold
          : GameMode.normalDoublePointsThreshold;
    } else {
      return isRound3
          ? GameMode.quickMimeDoublePointsThreshold
          : GameMode.quickDoublePointsThreshold;
    }
  }

  bool isInDoublePointsZone(WidgetRef ref, String timerValue) {
    if (!ref.read(doublePointsProvider)) return false;
    final remaining = int.tryParse(timerValue) ?? 0;
    if (remaining == 0) return false;
    return remaining <= getDoublePointsThreshold(ref);
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
