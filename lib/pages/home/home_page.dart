import 'package:asoscijacije_nove/constants/app_styles.dart';
import 'package:asoscijacije_nove/widgets/app_align_icon.dart';
import 'package:asoscijacije_nove/widgets/app_animated_menu_card.dart';
import 'package:asoscijacije_nove/widgets/app_header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:in_app_update/in_app_update.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../models/team.dart';
import '../../widgets/app_subtitle_text.dart';
import '../../widgets/cards/menu_card.dart';
import '../instructions/instructions_page.dart';
import '../start_game/start_game_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              const Spacer(),
              const AppTitleText(),
              const AppSubtitleText(),
              const Spacer(),
              const Stack(
                children: [
                  AppAnimatedMenuCard(
                    targetPage: StartGamePage(),
                    menuCardTitle: AppStrings.pocniIgru,
                    menuCardIcon: Icon(
                      Icons.play_arrow_rounded,
                      size: 45,
                      color: AppColors.white,
                    ),
                  ),
                  AppAlignIcon(
                    align: Alignment.topRight,
                    icon: Icon(
                      Icons.question_answer_rounded,
                      size: 100,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Stack(
                children: [
                  AppAnimatedMenuCard(
                    targetPage: InstructionsPage(),
                    menuCardTitle: AppStrings.uputstvaZaIgru,
                    menuCardIcon: Icon(
                      Icons.rule_sharp,
                      size: 45,
                      color: AppColors.white,
                    ),
                  ),
                  AppAlignIcon(
                    icon: Icon(
                      Icons.question_mark_rounded,
                      size: 100,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              MenuCard(
                title: AppStrings.izlaz,
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
