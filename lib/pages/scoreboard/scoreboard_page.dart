import 'package:asocijacije_nove/constants/app_colors.dart';
import 'package:asocijacije_nove/constants/app_styles.dart';
import 'package:asocijacije_nove/l10n/app_localizations.dart';
import 'package:asocijacije_nove/mixins/game_mixin.dart';
import 'package:asocijacije_nove/providers/all_providers.dart';
import 'package:asocijacije_nove/widgets/app_page_header.dart';
import 'package:asocijacije_nove/widgets/buttons/base-buttons/app_button_full.dart';
import 'package:asocijacije_nove/widgets/cards/team_card.dart';
import 'package:asocijacije_nove/widgets/neon_background.dart';
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
    final localizations = AppLocalizations.of(context)!;
    final box = Boxes.getTeams();
    final teams = <Team>[];
    if (box != null) {
      for (var i = 1; i <= box.length; i++) {
        final team = Boxes.getTeamById(box, 'tim-$i');
        if (team != null) teams.add(team);
      }
    }

    // Leader = highest points; none when everyone is tied at 0 (no leader yet).
    int leaderIndex = -1;
    int leaderPoints = -1;
    var tie = false;
    for (var i = 0; i < teams.length; i++) {
      final p = teams[i].points;
      if (p > leaderPoints) {
        leaderPoints = p;
        leaderIndex = i;
        tie = false;
      } else if (p == leaderPoints) {
        tie = true;
      }
    }
    if (leaderPoints <= 0 || tie) leaderIndex = -1;

    final nextTeam = Boxes.getTeamById(
      Hive.box<Team>('teams'),
      'tim-${ref.watch(gameAdminProvider).teamPlaying}',
    );

    return Scaffold(
      body: NeonBackground(
        child: SafeArea(
          child: PopScope(
            canPop: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 10, 24, 18),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  const Text('🏆', style: TextStyle(fontSize: 38)),
                  const SizedBox(height: 4),
                  AppPageHeader(title: localizations.rezultat, fontSize: 30),
                  const SizedBox(height: 30),
                  for (var i = 0; i < teams.length; i++) ...[
                    _ScoreRow(
                      team: teams[i],
                      color: teamColorFor(i),
                      isLeader: i == leaderIndex,
                    ),
                    const SizedBox(height: 16),
                  ],
                  const Spacer(),
                  if (nextTeam != null)
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: NeonText.display(size: 17, color: AppColors.ink),
                        children: [
                          TextSpan(text: '${localizations.sledeciIgraTim} '),
                          TextSpan(
                            text: nextTeam.teamName,
                            style: NeonText.display(
                              size: 17,
                              color: AppColors.cyan,
                            ),
                          ),
                          const TextSpan(text: ' 🎤'),
                        ],
                      ),
                    ),
                  const SizedBox(height: 14),
                  AppButtonFull(
                    buttonText: localizations.dalje,
                    fillColor: AppColors.orange,
                    textColor: AppColors.inkOnFill,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ScoreRow extends StatelessWidget {
  const _ScoreRow({
    required this.team,
    required this.color,
    required this.isLeader,
  });

  final Team team;
  final Color color;
  final bool isLeader;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: isLeader
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color.withValues(alpha: 0.16),
                  Colors.white.withValues(alpha: 0.03),
                ],
              )
            : null,
        color: isLeader ? null : Colors.white.withValues(alpha: 0.04),
        border: Border.all(
          color: isLeader ? color : Colors.white.withValues(alpha: 0.1),
          width: 1.5,
        ),
        boxShadow: isLeader
            ? [BoxShadow(color: color.withValues(alpha: 0.2), blurRadius: 26)]
            : null,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  team.teamName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: NeonText.display(size: 22, color: AppColors.ink),
                ),
                const SizedBox(height: 2),
                Text(
                  '${team.player1} · ${team.player2}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: NeonText.body(
                    size: 12.5,
                    weight: FontWeight.w600,
                    color: AppColors.sub,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '${team.points}',
            style: NeonText.display(
              size: 44,
              height: 1,
              color: isLeader ? color : AppColors.ink,
              shadows: isLeader
                  ? NeonText.glow(color, blur: 20, opacity: 0.53)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
