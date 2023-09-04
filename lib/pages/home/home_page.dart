import 'package:asoscijacije_nove/constants/app_styles.dart';
import 'package:asoscijacije_nove/providers/all_providers.dart';
import 'package:asoscijacije_nove/widgets/app_animated_menu_card.dart';

import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:in_app_update/in_app_update.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../models/team.dart';
import '../../widgets/cards/menu_card.dart';
import '../instructions/instructions_page.dart';
import '../start_game/start_game_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageConsumerState();
}

class _HomePageConsumerState extends ConsumerState<HomePage> {
  @override
  void initState() {
    _checkForUpdate();
    super.initState();
  }

  List<Locale> locales = [Locale('sr'), Locale('en')];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: AppStyles.containerGradientViolet,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 50,
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
              Spacer(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.asocijacije,
                    style: AppStyles.text50WhiteBold,
                  ),
                  Text(
                    '.',
                    style: AppStyles.text50CoralBold,
                  ),
                ],
              ),
              Center(
                  child: Text(AppLocalizations.of(context)!.saPapiricaUApp,
                      style: AppStyles.text20CoralBold)),
              const Spacer(),
              Stack(
                children: [
                  AppAnimatedMenuCard(
                    targetPage: const StartGamePage(),
                    menuCardTitle: AppLocalizations.of(context)!.pocniIgru,
                    menuCardIcon: const Icon(
                      Icons.play_arrow_rounded,
                      size: 45,
                      color: AppColors.white,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      transform: Matrix4.translationValues(-25, -45.0, 0.0),
                      child: ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (Rect bounds) => const RadialGradient(
                          center: Alignment.topCenter,
                          stops: [.2, 1],
                          colors: [
                            AppColors.white,
                            AppColors.whiteDarker,
                          ],
                        ).createShader(bounds),
                        child: const Icon(
                          Icons.question_answer_rounded,
                          size: 100,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Stack(
                children: [
                  AppAnimatedMenuCard(
                    targetPage: const InstructionsPage(),
                    menuCardTitle: AppLocalizations.of(context)!.uputstvaZaIgru,
                    menuCardIcon: const Icon(
                      Icons.rule_sharp,
                      size: 45,
                      color: AppColors.white,
                    ),
                  ),
                  Container(
                    transform: Matrix4.translationValues(15.0, -35.0, 0.0),
                    child: ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (Rect bounds) => const RadialGradient(
                        center: Alignment.topCenter,
                        stops: [.2, 1],
                        colors: [
                          AppColors.white,
                          AppColors.whiteDarker,
                        ],
                      ).createShader(bounds),
                      child: const Icon(
                        Icons.question_mark_rounded,
                        size: 100,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              MenuCard(
                title: AppLocalizations.of(context)!.izlaz,
                icon: const Icon(
                  Icons.exit_to_app_rounded,
                  size: 40,
                  color: AppColors.white,
                ),
                colors: const [
                  AppColors.englishVioletDarker,
                  AppColors.englishViolet,
                ],
                alignment: CrossAxisAlignment.start,
                rowAlignment: MainAxisAlignment.start,
                onTap: () async {
                  if (Hive.isBoxOpen('teams')) {
                    await Hive.box<Team>('teams').close();
                  }
                  SystemNavigator.pop();
                },
              ),
              const Spacer(),
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
