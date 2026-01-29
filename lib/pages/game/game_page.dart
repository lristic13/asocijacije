import 'package:asocijacije_nove/l10n/app_localizations.dart';
import 'package:asocijacije_nove/mixins/game_mixin.dart';
import 'package:asocijacije_nove/models/game_mode.dart';
import 'package:asocijacije_nove/pages/instructions/instructions_page.dart';
import 'package:asocijacije_nove/providers/all_providers.dart';
import 'package:asocijacije_nove/services/navigation_service.dart';
import 'package:asocijacije_nove/util/boxes.dart';
import 'package:asocijacije_nove/widgets/app_alert_dialog.dart';
import 'package:asocijacije_nove/widgets/app_cards_builder.dart';
import 'package:asocijacije_nove/widgets/app_explaining_row.dart';
import 'package:asocijacije_nove/widgets/app_final_score.dart';
import 'package:asocijacije_nove/widgets/app_page_header.dart';
import 'package:asocijacije_nove/widgets/app_points.dart';
import 'package:asocijacije_nove/widgets/app_timer.dart';
import 'package:asocijacije_nove/widgets/buttons/app_icon_button.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:page_transition/page_transition.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';
import '../../models/team.dart';
import '../../widgets/buttons/app_ingame_button.dart';
import '../../widgets/app_separator.dart';

class GamePage extends ConsumerStatefulWidget {
  const GamePage({super.key});

  @override
  ConsumerState<GamePage> createState() => _GamePageConsumerState();
}

class _GamePageConsumerState extends ConsumerState<GamePage> with GameMixin {
  final CountDownController _controllerTimer = CountDownController();
  final CardSwiperController _cardSwiperController = CardSwiperController();

  int indexToScroll = 1;

  bool timerCompleted = false;
  late Box<Team> box;
  String player1 = 'Player 1';
  String player2 = 'Player 2';
  String teamName = '';

  @override
  void initState() {
    super.initState();
    final openBox = Boxes.getTeams();
    if (openBox == null) {
      debugPrint('Teams box not available');
      return;
    }
    box = openBox;
    final team = Boxes.getTeamById(
      box,
      'tim-${ref.read(gameAdminProvider).teamPlaying}',
    );
    player1 = team?.player1 ?? 'Player 1';
    player2 = team?.player2 ?? 'Player 2';
    teamName = team?.teamName ?? '';
  }

  @override
  Widget build(BuildContext context) {
    int playerExplaining = ref.watch(gameAdminProvider).playerExplaining;
    List<String> wordsToPlay = ref.watch(wordsProvider).wordsToPlay;
    List<String> usedWords = ref.watch(wordsProvider).usedWords;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) {
            showModalBottomSheet(
              context: context,
              builder: (context) => AppAlertDialog(
                title: AppLocalizations.of(context)!.izlaz,
                content: AppLocalizations.of(context)!.daLiSteSigurniIzlaz,
                onPressedNo: () {
                  Navigator.of(context).pop();
                  _controllerTimer.resume();
                  setState(() {});
                },
                onPressedYes: () {
                  ref
                      .read(gameAdminProvider.notifier)
                      .update((state) => state.resetGame());
                  ref.read(wordsProvider).resetWords();
                  ref
                      .read(doublePointsProvider.notifier)
                      .update((state) => false);
                  NavigationService.goToHome();
                },
              ),
            );
          }
        },
        child: Container(
          color: AppColors.englishVioletDarker,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
            child:
                ref.read(gameAdminProvider).roundInProgress ==
                    GameMode.finalRound
                ? AppFinalScore(box: box)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          AppPageHeader(title: getRoundTitle(ref, context)),
                          const Spacer(),
                          AppIconButton(
                            onButtonPressed: () {
                              _controllerTimer.pause();
                              setState(() {});
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.topToBottom,
                                  curve: Curves.easeIn,
                                  duration: const Duration(milliseconds: 300),
                                  child: const InstructionsPage(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const AppSeparator(color: AppColors.coral),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          AppTimer(
                            controllerTimer: _controllerTimer,
                            ref: ref,
                            onTimerComplete: () {
                              setState(() {
                                timerCompleted = true;
                              });
                            },
                          ),
                          AppPoints(box: box, ref: ref),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Text(teamName, style: AppStyles.text25WhiteBold),
                      ),
                      const SizedBox(height: 5),
                      AppExplainingRow(
                        playerExplaining: playerExplaining,
                        player1: player1,
                        player2: player2,
                      ),
                      AppCardsBuilder(
                        swiperController: _cardSwiperController,
                        timerController: _controllerTimer,
                      ),
                      const SizedBox(height: 10),
                      AppInGameButton(
                        wordsToPlay: wordsToPlay,
                        usedWords: usedWords,
                        timerController: _controllerTimer,
                        ref: ref,
                        box: box,
                        timerCompleted: timerCompleted,
                        cardSwiper: _cardSwiperController,
                        updateParentState: () {
                          setState(() {});
                        },
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
