import 'dart:ui';

import 'package:asoscijacije_nove/widgets/app_separator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../constants/app_colors.dart';
import '../constants/app_styles.dart';
import '../providers/all_providers.dart';

class AppCardsBuilder extends ConsumerWidget {
  const AppCardsBuilder({
    required this.swiperController,
    super.key,
  });

  final CardSwiperController swiperController;

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
                cardsCount: ref.read(wordsProvider).wordsToPlay.length + 2,
                cardBuilder: (
                  context,
                  index,
                  horizontalOffsetPercentage,
                  verticalOffsetPercentage,
                ) =>
                    Center(
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: AppSeparator(
                                      color: AppColors.englishVioletDarker),
                                ),
                                shouldBlur
                                    ? ImageFiltered(
                                        imageFilter: ImageFilter.blur(
                                            sigmaX: 6, sigmaY: 6),
                                        child: Center(
                                          child: Text(
                                            ref
                                                .watch(wordsProvider)
                                                .wordsToPlay[0],
                                            style: AppStyles.text25WhiteBold
                                                .copyWith(fontSize: 28),
                                          ),
                                        ),
                                      )
                                    : Center(
                                        child: Text(
                                          ref
                                              .watch(wordsProvider)
                                              .wordsToPlay[0],
                                          style: AppStyles.text25WhiteBold
                                              .copyWith(fontSize: 28),
                                        ),
                                      ),
                                const Align(
                                  alignment: Alignment.centerRight,
                                  child: AppSeparator(
                                      color: AppColors.englishVioletDarker),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ))
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
