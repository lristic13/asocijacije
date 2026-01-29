import 'dart:ui';

import 'package:asocijacije_nove/l10n/app_localizations.dart';
import 'package:asocijacije_nove/mixins/game_mixin.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_colors.dart';
import '../constants/app_styles.dart';
import '../providers/all_providers.dart';

class AppCardsBuilder extends ConsumerWidget with GameMixin {
  const AppCardsBuilder({
    required this.swiperController,
    required this.timerController,
    super.key,
  });

  /// Extra cards needed by CardSwiper to render the stack effect.
  static const int _cardsBufferCount = 2;

  final CardSwiperController swiperController;
  final CountDownController timerController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool shouldBlur = ref.watch(blurProvider);
    return Expanded(
      flex: 4,
      child: Center(
        child: ref.watch(wordsProvider).wordsToPlay.isNotEmpty
            ? CardSwiper(
                controller: swiperController,
                isDisabled: true,
                cardsCount:
                    ref.read(wordsProvider).wordsToPlay.length +
                    _cardsBufferCount,
                cardBuilder:
                    (
                      context,
                      index,
                      horizontalOffsetPercentage,
                      verticalOffsetPercentage,
                    ) => Center(
                      child: Card(
                        color: AppColors.englishVioletLighter,
                        elevation: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: AppColors.englishVioletLighter,
                          ),
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Stack(
                              children: [
                                if (!shouldBlur &&
                                    !isInDoublePointsZone(
                                      ref,
                                      timerController.getTime() ?? '0',
                                    ))
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.englishVioletDarker,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0,
                                          vertical: 4,
                                        ),
                                        child: Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.dvaPoena,
                                          style: AppStyles.text15WhiteBold,
                                        ),
                                      ),
                                    ),
                                  ),

                                shouldBlur
                                    ? ImageFiltered(
                                        imageFilter: ImageFilter.blur(
                                          sigmaX: 6,
                                          sigmaY: 6,
                                        ),
                                        child: Center(
                                          child: Text(
                                            ref
                                                .watch(wordsProvider)
                                                .wordsToPlay[0],
                                            style: AppStyles.text30WhiteBold
                                                .copyWith(fontSize: 28),
                                          ),
                                        ),
                                      )
                                    : Center(
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          ref
                                              .watch(wordsProvider)
                                              .wordsToPlay[0],
                                          style: AppStyles.text30WhiteBold
                                              .copyWith(fontSize: 28),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
              )
            : Center(
                child: Text(
                  AppLocalizations.of(context)!.pogodjeneSveReci,
                  textAlign: TextAlign.center,
                  style: AppStyles.text25CoralBold,
                ),
              ),
      ),
    );
  }
}
