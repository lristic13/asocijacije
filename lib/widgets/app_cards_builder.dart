import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
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
    return Center(
      child: ref.watch(wordsProvider).wordsToPlay.isNotEmpty
          ? CardSwiper(
              controller: swiperController,
              isDisabled: true,
              cardsCount: ref.read(wordsProvider).wordsToPlay.length + 2,
              cardBuilder: (context, index, horizontalOffsetPercentage,
                      verticalOffsetPercentage) =>
                  Center(
                    child: Card(
                      elevation: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: AppColors.white,
                        ),
                        height: 360,
                        width: 290,
                        child: Center(
                            child: Text(
                          ref.watch(wordsProvider).wordsToPlay[0],
                          style:
                              AppStyles.text25VioletBold.copyWith(fontSize: 28),
                        )),
                      ),
                    ),
                  ))
          : const Center(
              child: Text(
                AppStrings.pogodjeneSveReci,
                textAlign: TextAlign.center,
                style: AppStyles.text25CoralBold,
              ),
            ),
    );
  }
}
