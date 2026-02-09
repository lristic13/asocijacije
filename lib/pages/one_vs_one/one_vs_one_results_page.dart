import 'package:asocijacije_nove/constants/app_colors.dart';
import 'package:asocijacije_nove/constants/app_styles.dart';
import 'package:asocijacije_nove/l10n/app_localizations.dart';
import 'package:asocijacije_nove/providers/all_providers.dart';
import 'package:asocijacije_nove/services/navigation_service.dart';
import 'package:asocijacije_nove/widgets/app_page_header.dart';
import 'package:asocijacije_nove/widgets/app_separator.dart';
import 'package:asocijacije_nove/widgets/buttons/base-buttons/app_button_full.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';

import '../game/game_page.dart';

class OneVsOneResultsPage extends ConsumerWidget {
  const OneVsOneResultsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final oneVsOne = ref.watch(oneVsOneProvider);

    return Scaffold(
      backgroundColor: AppColors.englishVioletDarker,
      body: PopScope(
        canPop: false,
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 20,
            left: 20,
            right: 20,
            top: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              AppPageHeader(title: localizations.krajIgre),
              const AppSeparator(color: AppColors.coral),
              const Spacer(),

              // Winner announcement
              Center(
                child: Column(
                  children: [
                    Icon(
                      oneVsOne.isTie ? Icons.handshake : Icons.emoji_events,
                      color: AppColors.coral,
                      size: 80,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      oneVsOne.isTie
                          ? localizations.nereseno
                          : localizations.pobednik(oneVsOne.winnerName),
                      style: AppStyles.text35WhiteBold,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Player scores
              _PlayerResultCard(
                playerName: oneVsOne.player1Name,
                score: oneVsOne.player1Score,
                isWinner:
                    !oneVsOne.isTie &&
                    oneVsOne.player1Score > oneVsOne.player2Score,
              ),
              const SizedBox(height: 12),
              _PlayerResultCard(
                playerName: oneVsOne.player2Name,
                score: oneVsOne.player2Score,
                isWinner:
                    !oneVsOne.isTie &&
                    oneVsOne.player2Score > oneVsOne.player1Score,
              ),

              const Spacer(),

              // Action buttons
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: AppButtonFull(
                  buttonText: localizations.igrajPonovo,
                  fillColor: AppColors.coral,
                  textColor: AppColors.englishVioletDarker,
                  onPressed: () => _playAgain(context, ref),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: AppButtonFull(
                  buttonText: localizations.novaIgra,
                  fillColor: AppColors.englishVioletLighter,
                  textColor: AppColors.white,
                  onPressed: () => _goHome(ref),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _playAgain(BuildContext context, WidgetRef ref) {
    // Reset scores but keep player names
    ref.read(oneVsOneProvider.notifier).update((state) => state.resetScores());

    // Reset game state but keep 1v1 mode
    ref
        .read(gameAdminProvider.notifier)
        .update(
          (state) => state.copyWith(
            roundInProgress: 1,
            playerExplaining: 1,
            teamPlaying: 1,
            allWordsGuessed: false,
          ),
        );

    // Reload words
    ref.read(wordsProvider).refreshWords();
    ref.read(blurProvider.notifier).update((state) => true);

    // Navigate to game
    Navigator.pushAndRemoveUntil(
      context,
      PageTransition(child: const GamePage(), type: PageTransitionType.fade),
      (route) => false,
    );
  }

  void _goHome(WidgetRef ref) {
    // Reset all state
    ref.read(gameAdminProvider.notifier).update((state) => state.resetGame());
    ref.read(wordsProvider).resetWords();
    ref.read(oneVsOneProvider.notifier).update((state) => state.reset());
    ref.read(doublePointsProvider.notifier).update((state) => false);

    NavigationService.goToHome();
  }
}

class _PlayerResultCard extends StatelessWidget {
  const _PlayerResultCard({
    required this.playerName,
    required this.score,
    required this.isWinner,
  });

  final String playerName;
  final int score;
  final bool isWinner;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isWinner ? AppColors.coral : AppColors.englishVioletLighter,
            width: isWinner ? 4 : 2,
          ),
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.englishVioletDarker, AppColors.englishViolet],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
          child: Row(
            children: [
              if (isWinner)
                const Padding(
                  padding: EdgeInsets.only(right: 12.0),
                  child: Icon(Icons.star, color: AppColors.coral, size: 32),
                ),
              Expanded(
                child: Text(
                  playerName,
                  style: AppStyles.text30WhiteBold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '$score',
                style: isWinner
                    ? AppStyles.text50CoralBold
                    : AppStyles.text45WhiteBold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
