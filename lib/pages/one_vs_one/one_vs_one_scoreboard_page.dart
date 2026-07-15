import 'package:asocijacije_nove/constants/app_colors.dart';
import 'package:asocijacije_nove/constants/app_styles.dart';
import 'package:asocijacije_nove/l10n/app_localizations.dart';
import 'package:asocijacije_nove/mixins/game_mixin.dart';
import 'package:asocijacije_nove/providers/all_providers.dart';
import 'package:asocijacije_nove/widgets/app_page_header.dart';
import 'package:asocijacije_nove/widgets/app_separator.dart';
import 'package:asocijacije_nove/widgets/buttons/base-buttons/app_button_full.dart';
import 'package:asocijacije_nove/widgets/neon_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';

import '../game/game_page.dart';

class OneVsOneScoreboardPage extends ConsumerStatefulWidget {
  const OneVsOneScoreboardPage({super.key});

  @override
  ConsumerState<OneVsOneScoreboardPage> createState() =>
      _OneVsOneScoreboardPageState();
}

class _OneVsOneScoreboardPageState extends ConsumerState<OneVsOneScoreboardPage>
    with GameMixin {
  @override
  Widget build(BuildContext context) {
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
                  AppPageHeader(title: localizations.rezultat),
                  const AppSeparator(color: AppColors.orange),
                const Spacer(),

                // Player 1 score card
                _PlayerScoreCard(
                  playerName: oneVsOne.player1Name,
                  score: oneVsOne.player1Score,
                  isCurrentPlayer: oneVsOne.currentPlayer == 1,
                ),
                const SizedBox(height: 12),

                // Player 2 score card
                _PlayerScoreCard(
                  playerName: oneVsOne.player2Name,
                  score: oneVsOne.player2Score,
                  isCurrentPlayer: oneVsOne.currentPlayer == 2,
                ),

                const Spacer(),

                // Next player indicator
                  Center(
                    child: Text(
                      localizations.objasnjava(oneVsOne.currentPlayerName),
                      style: NeonText.display(size: 19, color: AppColors.ink),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Continue button
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: AppButtonFull(
                      buttonText: localizations.dalje,
                      fillColor: AppColors.orange,
                      textColor: AppColors.inkOnFill,
                      onPressed: () {
                        if (context.mounted) {
                          if (ref.read(wordsProvider).wordsToPlay.isEmpty) {
                            allWordsGuessed(context, ref);
                          } else {
                            Navigator.push(
                              context,
                              PageTransition(
                                child: const GamePage(),
                                type: PageTransitionType.leftToRight,
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PlayerScoreCard extends StatelessWidget {
  const _PlayerScoreCard({
    required this.playerName,
    required this.score,
    required this.isCurrentPlayer,
  });

  final String playerName;
  final int score;
  final bool isCurrentPlayer;

  @override
  Widget build(BuildContext context) {
    final color = isCurrentPlayer ? AppColors.cyan : AppColors.violet;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isCurrentPlayer ? color : Colors.white.withValues(alpha: 0.1),
          width: 1.5,
        ),
        boxShadow: isCurrentPlayer
            ? [BoxShadow(color: color.withValues(alpha: 0.2), blurRadius: 26)]
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18),
        child: Row(
          children: [
            if (isCurrentPlayer)
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.arrow_forward,
                  color: AppColors.cyan,
                  size: 22,
                ),
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
                color: isCurrentPlayer ? AppColors.cyan : AppColors.ink,
                shadows: isCurrentPlayer
                    ? NeonText.glow(AppColors.cyan, blur: 20, opacity: 0.5)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
