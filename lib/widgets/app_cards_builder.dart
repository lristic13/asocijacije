import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../constants/app_styles.dart';
import '../providers/all_providers.dart';

class AppCardsBuilder extends ConsumerWidget {
  const AppCardsBuilder({
    required this.cardKey,
    super.key,
  });

  final GlobalKey<FlipCardState> cardKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ref.watch(wordsProvider).wordsToPlay.isNotEmpty
          ? FlipCard(
              key: cardKey,
              speed: 300,
              fill: Fill.fillBack,
              direction: FlipDirection.HORIZONTAL,
              side: CardSide.BACK,
              front: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: AppColors.white,
                ),
                margin: const EdgeInsets.only(right: 25, left: 25),
                height: 300,
                width: 250,
                child: Center(
                    child: Text(
                  ref.watch(wordsProvider).wordsToPlay[0],
                  style: AppStyles.text25VioletBold,
                )),
              ),
              back: Container(
                decoration: BoxDecoration(
                  color: AppColors.englishVioletLighter,
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(color: AppColors.white, width: 15),
                ),
                margin: const EdgeInsets.only(right: 25, left: 25),
                height: 300,
                width: 200,
                child: const Center(
                  child: Text(
                    '${AppStrings.asocijacije}.',
                    style: AppStyles.text25Violet900,
                  ),
                ),
              ),
            )
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
