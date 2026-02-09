import 'package:asocijacije_nove/constants/app_colors.dart';
import 'package:asocijacije_nove/constants/app_styles.dart';
import 'package:asocijacije_nove/l10n/app_localizations.dart';
import 'package:asocijacije_nove/mixins/game_mixin.dart';
import 'package:asocijacije_nove/providers/all_providers.dart';
import 'package:asocijacije_nove/widgets/app_page_header.dart';
import 'package:asocijacije_nove/widgets/app_separator.dart';
import 'package:asocijacije_nove/widgets/buttons/base-buttons/app_button_full.dart';
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
      backgroundColor: AppColors.englishViolet,
      body: PopScope(
        canPop: false,
        child: Container(
          color: AppColors.englishVioletDarker,
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
                AppPageHeader(title: localizations.rezultat),
                const AppSeparator(color: AppColors.coral),
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
                    style: AppStyles.text25WhiteBold,
                  ),
                ),
                const SizedBox(height: 10),

                // Continue button
                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: AppButtonFull(
                    buttonText: localizations.dalje,
                    fillColor: AppColors.coral,
                    textColor: AppColors.englishVioletDarker,
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
    return Card(
      elevation: 5,
      color: AppColors.white,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isCurrentPlayer ? AppColors.coral : AppColors.englishVioletLighter,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.englishVioletDarker,
              AppColors.englishViolet,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
            vertical: 16,
          ),
          child: Row(
            children: [
              if (isCurrentPlayer)
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.arrow_forward,
                    color: AppColors.coral,
                    size: 24,
                  ),
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
                style: AppStyles.text45WhiteBold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
