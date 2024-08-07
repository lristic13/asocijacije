import 'package:asoscijacije_nove/constants/app_routes.dart';
import 'package:asoscijacije_nove/mixins/game_mixin.dart';
import 'package:asoscijacije_nove/pages/instructions/instructions_page.dart';
import 'package:asoscijacije_nove/providers/all_providers.dart';
import 'package:asoscijacije_nove/util/boxes.dart';
import 'package:asoscijacije_nove/widgets/app_alert_dialog.dart';
import 'package:asoscijacije_nove/widgets/app_cards_builder.dart';
import 'package:asoscijacije_nove/widgets/app_explaining_row.dart';
import 'package:asoscijacije_nove/widgets/app_final_score.dart';
import 'package:asoscijacije_nove/widgets/app_page_header.dart';
import 'package:asoscijacije_nove/widgets/app_points.dart';
import 'package:asoscijacije_nove/widgets/app_timer.dart';
import 'package:asoscijacije_nove/widgets/buttons/app_icon_button.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../constants/app_colors.dart';
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
  late String player1;
  late String player2;

  @override
  void initState() {
    super.initState();
    box = Hive.box<Team>('teams');
    player1 =
        Boxes.getTeamById(box, 'tim-${ref.read(gameAdminProvider).teamPlaying}')
            .player1;
    player2 =
        Boxes.getTeamById(box, 'tim-${ref.read(gameAdminProvider).teamPlaying}')
            .player2;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int playerExplaining = ref.watch(gameAdminProvider).playerExplaining;
    List<String> wordsToPlay = ref.watch(wordsProvider).wordsToPlay;
    List<String> usedWords = ref.watch(wordsProvider).usedWords;

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: WillPopScope(
          onWillPop: () {
            showDialog(
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
                  ref.read(gameAdminProvider).resetGame();
                  ref.read(wordsProvider).resetWords();
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.homePage, (route) => false);
                },
              ),
            );
            return Future.value(true);
          },
          child: Container(
            color: AppColors.englishVioletDarker,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
              child: ref.read(gameAdminProvider).roundInProgress == 4
                  ? AppFinalScore(box: box)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: const InstructionsPage()),
                                );
                              },
                            )
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
                        AppExplainingRow(
                          playerExplaining: playerExplaining,
                          player1: player1,
                          player2: player2,
                        ),
                        AppCardsBuilder(
                          swiperController: _cardSwiperController,
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
        ));
  }
}
