import 'package:asoscijacije_nove/mixins/game_mixin.dart';
import 'package:asoscijacije_nove/widgets/buttons/app_cancel_button.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';

import '../../constants/app_colors.dart';
import '../../providers/all_providers.dart';
import '../../util/boxes.dart';
import 'base-buttons/app_button_full.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppInGameButton extends StatefulWidget {
  const AppInGameButton(
      {required this.wordsToPlay,
      required this.usedWords,
      required this.index,
      required this.timerController,
      required this.ref,
      required this.box,
      required this.timerCompleted,
      required this.cardSwiper,
      required this.updateParentState,
      super.key});

  final List<String> wordsToPlay;
  final List<String> usedWords;
  final int index;
  final CountDownController timerController;
  final WidgetRef ref;
  final Box box;
  final bool timerCompleted;
  final CardSwiperController cardSwiper;
  final Function updateParentState;

  @override
  State<AppInGameButton> createState() => _AppInGameButtonState();
}

class _AppInGameButtonState extends State<AppInGameButton> with GameMixin {
  var audio = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    if (widget.timerController.getTime() != '0' &&
        widget.timerController.getTime() != '' &&
        !widget.timerController.isPaused &&
        widget.wordsToPlay.isNotEmpty) {
      return Row(
        children: [
          Expanded(
            child: AppCancelButton(
              timerController: widget.timerController,
              wordsToPlay: widget.wordsToPlay,
              ref: widget.ref,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.075,
              child: AppButtonFull(
                fillColor: AppColors.coral,
                textColor: AppColors.englishVioletDarker,
                buttonText: AppLocalizations.of(context)!.sledecaRec,
                onPressed: () async {
                  await audio.setAsset('assets/sounds/correct-choice.mp3');
                  audio.play();
                  Boxes.addPoints(widget.box,
                      'tim-${widget.ref.read(gameAdminProvider).teamPlaying}');
                  widget.ref.read(wordsProvider).addWord(widget.wordsToPlay[0]);
                  widget.ref
                      .read(wordsProvider)
                      .removeWord(widget.wordsToPlay[0]);
                  widget.cardSwiper.swipeLeft();
                  // animateToIndex(indexToScroll++, pageController);
                },
              ),
            ),
          ),
        ],
      );
    } else if (widget.timerCompleted || widget.wordsToPlay.isEmpty) {
      return AppButtonFull(
        fillColor: AppColors.englishVioletLighter,
        textColor: AppColors.white,
        buttonText: AppLocalizations.of(context)!.sledeciTim,
        onPressed: () {
          widget.timerController.pause();
          roundEnd(context, widget.ref);
        },
      );
    } else {
      return AppButtonFull(
        fillColor: AppColors.englishVioletLighter,
        textColor: AppColors.englishVioletDarker,
        buttonText: AppLocalizations.of(context)!.start,
        onPressed: () {
          if (widget.timerController.isPaused) {
            widget.timerController.resume();
          } else {
            widget.timerController.start();
          }

          widget.ref.read(blurProvider.notifier).state = false;

          widget.updateParentState();
        },
      );
    }
  }
}
