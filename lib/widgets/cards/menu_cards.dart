import 'package:asoscijacije_nove/constants/app_colors.dart';
import 'package:asoscijacije_nove/constants/app_routes.dart';
import 'package:asoscijacije_nove/constants/app_strings.dart';
import 'package:asoscijacije_nove/constants/app_styles.dart';
import 'package:asoscijacije_nove/widgets/app_separator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class MenuCards extends StatelessWidget {
  const MenuCards({required this.swiperController, super.key});

  final CardSwiperController swiperController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 8,
      child: CardSwiper(
        controller: swiperController,
        isDisabled: false,
        cardsCount: 2,
        backCardOffset: const Offset(20, -70),
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
                          Text(
                              index == 1
                                  ? AppStrings.pocniIgru
                                  : AppStrings.uputstva,
                              style: AppStyles.text25WhiteBold),
                          const Text('.', style: AppStyles.text25CoralBold),
                        ],
                      ),
                    ),
                    Center(
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.startGamePage);
                          },
                          icon: Icon(
                              index == 1
                                  ? Icons.play_arrow_rounded
                                  : Icons.rule_rounded,
                              size: 200,
                              color: AppColors.englishVioletDarker)),
                    ),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: AppSeparator(color: AppColors.englishVioletDarker),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
