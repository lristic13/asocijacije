import 'package:asocijacije_nove/constants/app_colors.dart';
import 'package:asocijacije_nove/constants/app_styles.dart';
import 'package:asocijacije_nove/l10n/app_localizations.dart';
import 'package:asocijacije_nove/providers/all_providers.dart';
import 'package:asocijacije_nove/services/navigation_service.dart';
import 'package:asocijacije_nove/widgets/app_page_header.dart';
import 'package:asocijacije_nove/widgets/app_separator.dart';
import 'package:asocijacije_nove/widgets/buttons/base-buttons/app_button_empty.dart';
import 'package:asocijacije_nove/widgets/buttons/base-buttons/app_button_full.dart';
import 'package:asocijacije_nove/widgets/neon_background.dart';
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
      body: NeonBackground(
        child: SafeArea(
          child: PopScope(
            canPop: false,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 18,
                left: 24,
                right: 24,
                top: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppPageHeader(title: localizations.krajIgre),
                  const AppSeparator(color: AppColors.orange),
              const Spacer(),

              // Winner announcement
              Center(
                child: Column(
                  children: [
                    Icon(
                      oneVsOne.isTie ? Icons.handshake : Icons.emoji_events,
                      color: AppColors.orange,
                      size: 80,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      oneVsOne.isTie
                          ? localizations.nereseno
                          : localizations.pobednik(oneVsOne.winnerName),
                      style: NeonText.display(
                        size: 32,
                        color: AppColors.ink,
                        shadows: NeonText.glow(
                          AppColors.orange,
                          blur: 24,
                          opacity: 0.5,
                        ),
                      ),
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
                padding: const EdgeInsets.only(bottom: 12.0),
                child: AppButtonFull(
                  buttonText: localizations.igrajPonovo,
                  fillColor: AppColors.orange,
                  textColor: AppColors.inkOnFill,
                  onPressed: () => _playAgain(context, ref),
                ),
              ),
              AppButtonEmpty(
                buttonText: localizations.novaIgra,
                borderColor: AppColors.cyan,
                textColor: AppColors.cyan,
                onPressed: () => _goHome(ref),
              ),
                ],
              ),
            ),
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
    final color = isWinner ? AppColors.orange : AppColors.violet;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isWinner ? color : Colors.white.withValues(alpha: 0.1),
          width: 1.5,
        ),
        boxShadow: isWinner
            ? [BoxShadow(color: color.withValues(alpha: 0.2), blurRadius: 26)]
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18),
        child: Row(
          children: [
            if (isWinner)
              const Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(Icons.star, color: AppColors.orange, size: 28),
              ),
            Expanded(
              child: Text(
                playerName,
                style: NeonText.display(size: 22, color: AppColors.ink),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              '$score',
              style: NeonText.display(
                size: 44,
                height: 1,
                color: isWinner ? AppColors.orange : AppColors.ink,
                shadows: isWinner
                    ? NeonText.glow(AppColors.orange, blur: 20, opacity: 0.5)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
