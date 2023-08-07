import 'package:asoscijacije_nove/constants/app_routes.dart';
import 'package:asoscijacije_nove/constants/app_strings.dart';
import 'package:asoscijacije_nove/constants/app_styles.dart';
import 'package:asoscijacije_nove/mixins/game_mixin.dart';
import 'package:asoscijacije_nove/pages/instructions/instructions_page.dart';
import 'package:asoscijacije_nove/providers/all_providers.dart';
import 'package:asoscijacije_nove/util/boxes.dart';
import 'package:asoscijacije_nove/widgets/app_alert_dialog.dart';
import 'package:asoscijacije_nove/widgets/app_cards_builder.dart';
import 'package:asoscijacije_nove/widgets/app_final_score.dart';
import 'package:asoscijacije_nove/widgets/buttons/app_button_empty.dart';
import 'package:asoscijacije_nove/widgets/buttons/app_button_full.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:page_transition/page_transition.dart';

import '../../constants/app_colors.dart';
import '../../models/team.dart';
import '../../widgets/app_separator.dart';

class GamePage extends ConsumerStatefulWidget {
  const GamePage({super.key});

  @override
  ConsumerState<GamePage> createState() => _GamePageConsumerState();
}

class _GamePageConsumerState extends ConsumerState<GamePage> with GameMixin {
  final AudioPlayer audio = AudioPlayer();
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
                title: AppStrings.izlaz,
                content: AppStrings.daLiSteSigurniIzlaz,
                onPressedNo: () {
                  Navigator.of(context).pop();
                  _controllerTimer.resume();
                  setState(() {});
                },
                onPressedYes: () {
                  ref.read(gameAdminProvider).resetGame();
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.homePage, (route) => false);
                },
              ),
            );
            return Future.value(true);
          },
          child: Container(
            decoration: AppStyles.containerGradientViolet,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: ref.read(gameAdminProvider).roundInProgress == 4
                  ? AppFinalScore(box: box)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                Text(getRoundTitle(ref),
                                    style: AppStyles.text25WhiteBold),
                                const Text('.',
                                    style: AppStyles.text25CoralBold),
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
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
                              icon: const Icon(Icons.info_outline,
                                  color: AppColors.white),
                            ),
                          ],
                        ),
                        const AppSeparator(color: AppColors.coral),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Center(
                                child: CircularCountDownTimer(
                                  controller: _controllerTimer,
                                  autoStart: false,
                                  textStyle: AppStyles.text50WhiteBold,
                                  strokeWidth: 15,
                                  isReverse: true,
                                  isReverseAnimation: true,
                                  width: 150,
                                  height: 150,
                                  duration: ref
                                              .read(gameAdminProvider)
                                              .roundInProgress ==
                                          3
                                      ? 60
                                      : 45,
                                  ringColor: AppColors.englishVioletDarker,
                                  fillColor: AppColors.coral,
                                  textFormat: CountdownTextFormat.S,
                                  onComplete: () {
                                    setState(() {
                                      timerCompleted = true;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    playerExplaining == 1 ? player1 : player2,
                                    style: AppStyles.text25WhiteBold,
                                  ),
                                  const Icon(Icons.arrow_downward_outlined,
                                      color: AppColors.coral, size: 30),
                                  Text(
                                    playerExplaining == 1 ? player2 : player1,
                                    style: AppStyles.text25WhiteBold,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          flex: 4,
                          child: AppCardsBuilder(
                            swiperController: _cardSwiperController,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: ValueListenableBuilder(
                              valueListenable: box.listenable(),
                              builder: (context, Box<Team> box, _) => Text(
                                  '${AppStrings.poeni}: ${Boxes.getTeamById(box, 'tim-${ref.read(gameAdminProvider).teamPlaying}').points.toString()}',
                                  style: AppStyles.text35WhiteBold),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: _showButton(wordsToPlay, usedWords,
                              indexToScroll, _controllerTimer),
                        ),
                        const SizedBox(height: 10),
                        Visibility(
                          visible: _controllerTimer.getTime() != '0' &&
                              _controllerTimer.getTime() != '' &&
                              !_controllerTimer.isPaused &&
                              wordsToPlay.isNotEmpty,
                          child: SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: AppButtonEmpty(
                              borderColor: AppColors.white,
                              textColor: AppColors.white,
                              buttonText: AppStrings.odustani,
                              textSize: 15,
                              onPressed: () {
                                _controllerTimer.pause();
                                setState(() {});
                                showDialog(
                                  context: context,
                                  builder: (context) => AppAlertDialog(
                                    title: AppStrings.odustajete,
                                    content: AppStrings.odustaniAlertContent,
                                    onPressedNo: () {
                                      Navigator.of(context).pop();
                                      _controllerTimer.resume();
                                      setState(() {});
                                    },
                                    onPressedYes: () {
                                      roundEnd(context, ref);
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
            ),
          ),
        ));
  }

  Widget _showButton(List<String> wordsToPlay, List<String> usedWords,
      int indexToScroll, CountDownController timerController) {
    if (timerController.getTime() != '0' &&
        timerController.getTime() != '' &&
        !timerController.isPaused &&
        wordsToPlay.isNotEmpty) {
      return AppButtonFull(
        fillColor: AppColors.coral,
        textColor: AppColors.englishVioletDarker,
        buttonText: AppStrings.sledecaRec,
        onPressed: () async {
          await audio.setAsset('assets/sounds/correct-choice.mp3');
          audio.play();
          Boxes.addPoints(
              box, 'tim-${ref.read(gameAdminProvider).teamPlaying}');
          ref.read(wordsProvider).addWord(wordsToPlay[0]);
          ref.read(wordsProvider).removeWord(wordsToPlay[0]);
          _cardSwiperController.swipeLeft();
          // animateToIndex(indexToScroll++, pageController);
        },
      );
    } else if (timerCompleted || wordsToPlay.isEmpty) {
      return AppButtonFull(
        fillColor: AppColors.englishVioletDarker,
        textColor: AppColors.white,
        buttonText: AppStrings.sledeciTim,
        onPressed: () {
          _controllerTimer.pause();
          roundEnd(context, ref);
        },
      );
    } else {
      return AppButtonFull(
        fillColor: AppColors.englishVioletDarker,
        textColor: AppColors.white,
        buttonText: AppStrings.start,
        onPressed: () {
          if (timerController.isPaused) {
            timerController.resume();
          } else {
            timerController.start();
          }

          setState(() {});
        },
      );
    }
  }
}
