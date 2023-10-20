import 'package:asoscijacije_nove/constants/app_colors.dart';
import 'package:asoscijacije_nove/constants/app_styles.dart';
import 'package:asoscijacije_nove/mixins/home_cards_mixin.dart';
import 'package:asoscijacije_nove/widgets/app_separator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuCards extends ConsumerWidget with HomeCardsMixin {
  const MenuCards({required this.swiperController, super.key});

  final CardSwiperController swiperController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      flex: 4,
      child: CardSwiper(
        controller: swiperController,
        initialIndex: 1,
        isDisabled: false,
        cardsCount: 3,
        numberOfCardsDisplayed: 3,
        backCardOffset: const Offset(20, -70),
        cardBuilder: (
          context,
          index,
          horizontalOffsetPercentage,
          verticalOffsetPercentage,
        ) {
          return Center(
            child: Card(
              color: AppColors.englishVioletLighter,
              elevation: 10,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: AppColors.englishVioletDarker,
                        offset: Offset(3, -3),
                        blurRadius: 20)
                  ],
                  borderRadius: BorderRadius.circular(13),
                  color: AppColors.englishVioletLighter,
                ),
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.7,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Text(determineText(index),
                                style: AppStyles.text25WhiteBold),
                            const Text('.', style: AppStyles.text25CoralBold),
                          ],
                        ),
                      ),
                      Center(
                        child: IconButton(
                            onPressed: determineTap(ref, context, index),
                            icon: determineIcon(context, index)),
                      ),
                      const Align(
                        alignment: Alignment.centerRight,
                        child:
                            AppSeparator(color: AppColors.englishVioletDarker),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
