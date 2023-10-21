import 'package:asoscijacije_nove/providers/all_providers.dart';
import 'package:asoscijacije_nove/widgets/app_header_text.dart';
import 'package:asoscijacije_nove/widgets/cards/menu_cards.dart';
import 'package:country_flags/country_flags.dart';
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

  List<Locale> locales = const [Locale('sr'), Locale('en')];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: AppColors.englishVioletDarker,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 30,
            left: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      foregroundDecoration:
                          ref.watch(localeProvider) != const Locale('sr')
                              ? const BoxDecoration(
                                  color: Colors.grey,
                                  backgroundBlendMode: BlendMode.saturation,
                                )
                              : null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        child: InkWell(
                          onTap: () {
                            ref.read(localeProvider.notifier).state =
                                const Locale('sr');
                          },
                          child: CountryFlag.fromCountryCode('rs',
                              height: 30, width: 30),
                        ),
                      )),
                  const SizedBox(width: 20),
                  Container(
                      foregroundDecoration:
                          ref.watch(localeProvider) != const Locale('us')
                              ? const BoxDecoration(
                                  color: Colors.grey,
                                  backgroundBlendMode: BlendMode.saturation,
                                )
                              : null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        child: InkWell(
                          onTap: () {
                            ref.read(localeProvider.notifier).state =
                                const Locale('us');
                          },
                          child: CountryFlag.fromCountryCode('us',
                              height: 30, width: 30),
                        ),
                      )),
                ],
              ),
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
