import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../constants/app_styles.dart';
import '../models/team.dart';
import '../providers/all_providers.dart';
import '../util/boxes.dart';
import 'buttons/app_button_full.dart';

class AppFinalScore extends ConsumerWidget {
  const AppFinalScore({required this.box, super.key});

  final Box<Team> box;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.krajIgre,
              style: AppStyles.text50WhiteBold,
            ),
            Text(
              '.',
              style: AppStyles.text50CoralBold,
            ),
          ],
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Text(
              'Pobenik je Tim ${Boxes.getWinnerTeam(box).substring(Boxes.getWinnerTeam(box).length - 1)}!',
              style: AppStyles.text25CoralBold,
            ),
          ),
        ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          height: 60,
          child: AppButtonFull(
            fillColor: AppColors.coral,
            textColor: AppColors.englishViolet,
            buttonText: AppStrings.novaIgra,
            onPressed: () {
              ref.read(gameAdminProvider).resetGame();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/startGame', (route) => false);
            },
          ),
        ),
      ],
    );
  }
}
