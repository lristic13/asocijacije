import 'package:asocijacije_nove/l10n/app_localizations.dart';
import 'package:asocijacije_nove/mixins/game_mixin.dart';
import 'package:asocijacije_nove/widgets/buttons/app_cancel_button.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';

import '../../constants/app_colors.dart';
import '../../providers/all_providers.dart';
import '../../util/boxes.dart';
import 'base-buttons/app_button_full.dart';

class AppInGameButton extends StatefulWidget {
  const AppInGameButton({
    required this.wordsToPlay,
    required this.usedWords,
    required this.timerController,
    required this.ref,
    required this.box,
    required this.timerCompleted,
    required this.cardSwiper,
    required this.updateParentState,
    super.key,
  });

  final List<String> wordsToPlay;
  final List<String> usedWords;

  final CountDownController timerController;
  final WidgetRef ref;
  final Box? box;
  final bool timerCompleted;
  final CardSwiperController cardSwiper;
  final Function updateParentState;

  @override
  State<AppInGameButton> createState() => _AppInGameButtonState();
}

class _AppInGameButtonState extends State<AppInGameButton> with GameMixin {
  final _audio = AudioPlayer();

  @override
  void dispose() {
    _audio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final is1v1Mode = widget.ref.watch(gameAdminProvider).is1v1Mode;

    if (widget.timerController.getTime() != '0' &&
        widget.timerController.getTime() != '' &&
        !widget.timerController.isPaused &&
        widget.wordsToPlay.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 25.0),
        child: Row(
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
              child: AppButtonFull(
                fillColor: AppColors.cyan,
                textColor: AppColors.inkOnFill,
                buttonText: AppLocalizations.of(context)!.sledecaRec,
                onPressed: () async {
                  await HapticFeedback.heavyImpact();
                  await _audio.setAsset('assets/sounds/correct-choice.mp3');
                  _audio.play();
                  final pointsToAdd =
                      isInDoublePointsZone(
                        widget.ref,
                        widget.timerController.getTime() ?? '0',
                      )
                      ? 2
                      : 1;

                  if (is1v1Mode) {
                    // Add points to current player in 1v1 mode
                    widget.ref.read(oneVsOneProvider.notifier).update(
                          (state) => state.addPointToCurrentPlayer(points: pointsToAdd),
                        );
                  } else {
                    // Add points to team in team mode
                    if (widget.box != null) {
                      bool success = Boxes.addPoints(
                        widget.box!,
                        'tim-${widget.ref.read(gameAdminProvider).teamPlaying}',
                        points: pointsToAdd,
                      );
                      if (!success) {
                        debugPrint('Failed to add points to team');
                      }
                    }
                  }

                  widget.ref.read(wordsProvider).addWord(widget.wordsToPlay[0]);
                  widget.ref
                      .read(wordsProvider)
                      .removeWord(widget.wordsToPlay[0]);
                  widget.cardSwiper.swipeLeft();
                },
              ),
            ),
          ],
        ),
      );
    } else if (widget.timerCompleted || widget.wordsToPlay.isEmpty) {
      // Show "Next player" for 1v1, "Next team" for team mode
      final buttonText = is1v1Mode
          ? AppLocalizations.of(context)!.sledeciIgrac
          : AppLocalizations.of(context)!.sledeciTim;

      return Padding(
        padding: const EdgeInsets.only(bottom: 25.0),
        child: AppButtonFull(
          fillColor: AppColors.orange,
          textColor: AppColors.inkOnFill,
          buttonText: buttonText,
          onPressed: () {
            widget.timerController.pause();
            roundEnd(context, widget.ref);
          },
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 25.0),
        child: AppButtonFull(
          fillColor: AppColors.orange,
          textColor: AppColors.inkOnFill,
          buttonText: AppLocalizations.of(context)!.start,
          onPressed: () {
            if (widget.timerController.isPaused) {
              widget.timerController.resume();
            } else {
              widget.timerController.start();
            }

            widget.ref.read(blurProvider.notifier).update((state) => false);

            widget.updateParentState();
          },
        ),
      );
    }
  }
}
