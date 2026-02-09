import 'package:asocijacije_nove/constants/app_styles.dart';
import 'package:asocijacije_nove/l10n/app_localizations.dart';
import 'package:asocijacije_nove/models/team.dart';
import 'package:asocijacije_nove/providers/all_providers.dart';
import 'package:asocijacije_nove/util/boxes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppPoints extends StatelessWidget {
  const AppPoints({required this.box, required this.ref, super.key});
  final Box<Team>? box;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final is1v1Mode = ref.watch(gameAdminProvider).is1v1Mode;

    if (is1v1Mode) {
      return _build1v1Points(context);
    }

    return _buildTeamPoints(context);
  }

  Widget _build1v1Points(BuildContext context) {
    final oneVsOne = ref.watch(oneVsOneProvider);
    final currentScore = oneVsOne.currentPlayer == 1
        ? oneVsOne.player1Score
        : oneVsOne.player2Score;

    return Expanded(
      flex: 2,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              AppLocalizations.of(context)!.poeni,
              style: AppStyles.text35WhiteBold,
            ),
            Text(
              currentScore.toString(),
              style: AppStyles.text60VioletLighterBold,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamPoints(BuildContext context) {
    if (box == null) {
      return Expanded(
        flex: 2,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                AppLocalizations.of(context)!.poeni,
                style: AppStyles.text35WhiteBold,
              ),
              const Text(
                '0',
                style: AppStyles.text60VioletLighterBold,
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      flex: 2,
      child: Center(
        child: ValueListenableBuilder(
          valueListenable: box!.listenable(),
          builder: (context, Box<Team> box, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                AppLocalizations.of(context)!.poeni,
                style: AppStyles.text35WhiteBold,
              ),
              Text(
                (Boxes.getTeamById(
                          box,
                          'tim-${ref.read(gameAdminProvider).teamPlaying}',
                        )?.points ??
                        0)
                    .toString(),
                style: AppStyles.text60VioletLighterBold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
