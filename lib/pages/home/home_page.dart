import 'package:asoscijacije_nove/providers/all_providers.dart';
import 'package:asoscijacije_nove/widgets/app_title_text.dart';
import 'package:asoscijacije_nove/widgets/app_languages_row.dart';
import 'package:asoscijacije_nove/widgets/cards/menu_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_update/in_app_update.dart';

import '../../constants/app_colors.dart';
import '../../widgets/app_subtitle_text.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageConsumerState();
}

class _HomePageConsumerState extends ConsumerState<HomePage> {
  final CardSwiperController _cardSwiperController = CardSwiperController();

  @override
  void initState() {
    _checkForUpdate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: AppColors.englishVioletDarker,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 40,
            left: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppLanguagesRow(),
              const Spacer(),
              const AppTitleText(),
              const AppSubtitleText(),
              const Spacer(),
              MenuCards(swiperController: _cardSwiperController),
            ],
          ),
        ),
      ),
    );
  }
}

void _checkForUpdate() {
  InAppUpdate.checkForUpdate().then((updateInfo) {
    if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
      if (updateInfo.immediateUpdateAllowed) {
        InAppUpdate.performImmediateUpdate();
      }
    }
  });
}
