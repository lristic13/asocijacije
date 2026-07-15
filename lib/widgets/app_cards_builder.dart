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
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [AppColors.cardLight, AppColors.card],
                          ),
                          border: Border.all(
                            color: AppColors.violet.withValues(alpha: 0.4),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.violet.withValues(alpha: 0.3),
                              blurRadius: 36,
                            ),
                          ],
                        ),
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width * 0.78,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 24,
                          ),
                          child: Stack(
                            children: [
                              if (!shouldBlur &&
                                  isInDoublePointsZone(
                                    ref,
                                    timerController.getTime() ?? '0',
                                  ))
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.cyan,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.cyan
                                              .withValues(alpha: 0.5),
                                          blurRadius: 16,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                        vertical: 4,
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context)!.dvaPoena,
                                        style: NeonText.body(
                                          size: 13,
                                          weight: FontWeight.w800,
                                          color: AppColors.inkOnFill,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .objasni
                                          .toUpperCase(),
                                      style: NeonText.body(
                                        size: 11,
                                        weight: FontWeight.w800,
                                        color: AppColors.violet,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    _word(
                                      ref.watch(wordsProvider).wordsToPlay[0],
                                      shouldBlur,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              )
            : Center(
                child: Text(
                  AppLocalizations.of(context)!.pogodjeneSveReci,
                  textAlign: TextAlign.center,
                  style: NeonText.display(size: 25, color: AppColors.orange),
                ),
              ),
      ),
    );
  }

  Widget _word(String word, bool shouldBlur) {
    final text = Text(
      word,
      textAlign: TextAlign.center,
      style: NeonText.display(
        size: 38,
        color: AppColors.ink,
        shadows: NeonText.glow(AppColors.ink, blur: 24, opacity: 0.25),
      ),
    );
    if (!shouldBlur) return text;
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: text,
    );
  }
}
