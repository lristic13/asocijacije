import 'package:asoscijacije_nove/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:page_transition/page_transition.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../models/team.dart';
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
              const Row(
                children: [
                  Text(
                    AppStrings.asocijacije,
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                      color: AppColors.white,
                    ),
                  ),
                  Text(
                    '.',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                      color: AppColors.coral,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Stack(
                children: [
                  MenuCard(
                    title: AppStrings.pocniIgru,
                    colors: const [
                      AppColors.white,
                      AppColors.whiteDarker,
                    ],
                    icon: const Icon(
                      Icons.play_arrow_rounded,
                      size: 60,
                      color: AppColors.englishViolet,
                    ),
                    alignment: CrossAxisAlignment.start,
                    rowAlignment: MainAxisAlignment.start,
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.topToBottom,
                          curve: Curves.easeIn,
                          duration: const Duration(milliseconds: 300),
                          child: const StartGamePage(),
                          childCurrent: widget,
                        ),
                      );
                    },
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
                            AppColors.coral,
                            AppColors.coralDarker,
                          ],
                        ).createShader(bounds),
                        child: const Icon(
                          Icons.question_answer_rounded,
                          size: 120,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              Stack(
                children: [
                  MenuCard(
                    title: AppStrings.uputstva,
                    icon: const Icon(
                      Icons.rule_sharp,
                      size: 60,
                      color: AppColors.englishViolet,
                    ),
                    colors: const [
                      AppColors.whiteDarker,
                      AppColors.white,
                    ],
                    alignment: CrossAxisAlignment.end,
                    rowAlignment: MainAxisAlignment.end,
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                            child: InstructionsPage(),
                            type: PageTransitionType.bottomToTop),
                      );
                    },
                  ),
                  Container(
                    transform: Matrix4.translationValues(15.0, -45.0, 0.0),
                    child: ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (Rect bounds) => const RadialGradient(
                        center: Alignment.topCenter,
                        stops: [.2, 1],
                        colors: [
                          AppColors.coral,
                          AppColors.coralDarker,
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
              const SizedBox(height: 60),
              MenuCard(
                title: AppStrings.izlaz,
                icon: const Icon(
                  Icons.exit_to_app_rounded,
                  size: 55,
                  color: AppColors.englishViolet,
                ),
                colors: const [
                  AppColors.whiteDarker,
                  AppColors.white,
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
