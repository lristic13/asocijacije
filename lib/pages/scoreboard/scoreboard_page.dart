import 'package:asoscijacije_nove/constants/app_colors.dart';
import 'package:asoscijacije_nove/constants/app_styles.dart';
import 'package:asoscijacije_nove/mixins/game_mixin.dart';
import 'package:asoscijacije_nove/providers/all_providers.dart';
import 'package:asoscijacije_nove/widgets/buttons/app_button_full.dart';
import 'package:asoscijacije_nove/widgets/app_separator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:page_transition/page_transition.dart';

import '../../constants/app_strings.dart';
import '../../models/team.dart';
import '../../util/boxes.dart';
import '../game/game_page.dart';

class ScoreBoardPage extends ConsumerStatefulWidget {
  const ScoreBoardPage({super.key});

  @override
  ConsumerState<ScoreBoardPage> createState() => _ScoreBoardPageConsumerState();
}

class _ScoreBoardPageConsumerState extends ConsumerState<ScoreBoardPage>
    with GameMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.englishViolet,
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Container(
          decoration: AppStyles.containerGradientViolet,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(AppStrings.rezultat,
                    style: AppStyles.text25WhiteBold),
                const AppSeparator(color: AppColors.coral),
                const Spacer(),
                Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 120,
                      ),
                      itemBuilder: (context, index) {
                        return Card(
                          color: AppColors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30.0,
                              vertical: 10,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Tim ${index + 1}',
                                  style: AppStyles.text20VioletBold,
                                ),
                                const Spacer(),
                                Text(
                                  '${Boxes.getTeamById(Hive.box<Team>('teams'), 'tim-${index + 1}').points}',
                                  style: AppStyles.text40VioletBold,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      shrinkWrap: true,
                      itemCount: Boxes.getTeams().length,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    '${AppStrings.sledeciIgraTim} ${ref.read(gameAdminProvider).teamPlaying}',
                    style: AppStyles.text20WhiteDarkerBold,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: AppButtonFull(
                    buttonText: AppStrings.dalje,
                    fillColor: AppColors.coral,
                    textColor: AppColors.englishVioletDarker,
                    onPressed: () {
                      if (context.mounted) {
                        if (ref.read(wordsProvider).wordsToPlay.isEmpty) {
                          allWordsGuessed(context, ref);
                        }
                        Navigator.push(
                            context,
                            PageTransition(
                                child: const GamePage(),
                                type: PageTransitionType.leftToRight));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
