import 'package:asoscijacije_nove/constants/app_colors.dart';
import 'package:asoscijacije_nove/constants/app_styles.dart';
import 'package:asoscijacije_nove/l10n/app_localizations.dart';
import 'package:asoscijacije_nove/mixins/game_mixin.dart';
import 'package:asoscijacije_nove/providers/all_providers.dart';
import 'package:asoscijacije_nove/widgets/app_page_header.dart';
import 'package:asoscijacije_nove/widgets/buttons/base-buttons/app_button_full.dart';
import 'package:asoscijacije_nove/widgets/app_separator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:page_transition/page_transition.dart';

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
      body: PopScope(
        canPop: false,
        child: Container(
          color: AppColors.englishVioletDarker,
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
              left: 20,
              right: 20,
              top: 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                AppPageHeader(title: AppLocalizations.of(context)!.rezultat),
                const AppSeparator(color: AppColors.coral),
                const Spacer(),
                Center(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      Team? currentTeam = Boxes.getTeamById(
                        Hive.box<Team>('teams'),
                        'tim-${index + 1}',
                      );
                      if (currentTeam == null) return const SizedBox.shrink();
                      return Card(
                        elevation: 5,
                        color: AppColors.white,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.coral,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.englishVioletDarker,
                                AppColors.englishViolet,
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30.0,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      currentTeam.teamName,
                                      style: AppStyles.text35WhiteBold,
                                    ),
                                    Text(
                                      '(${currentTeam.player1}, ${currentTeam.player2})',
                                      style: AppStyles.text15WhiteNormal,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Text(
                                  '${currentTeam.points}',
                                  style: AppStyles.text45WhiteBold,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    shrinkWrap: true,
                    itemCount: Boxes.getTeams()?.length ?? 0,
                  ),
                ),
                const Spacer(),
                Center(
                  child: Builder(
                    builder: (context) {
                      final nextTeam = Boxes.getTeamById(
                        Hive.box<Team>('teams'),
                        'tim-${ref.watch(gameAdminProvider).teamPlaying}',
                      );
                      return Text(
                        '${AppLocalizations.of(context)!.sledeciIgraTim} ${nextTeam?.teamName ?? ref.watch(gameAdminProvider).teamPlaying}!',
                        style: AppStyles.text25WhiteBold,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: AppButtonFull(
                    buttonText: AppLocalizations.of(context)!.dalje,
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
                            type: PageTransitionType.leftToRight,
                          ),
                        );
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
