import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_colors.dart';
import '../constants/app_styles.dart';
import '../providers/all_providers.dart';

class AppTimer extends StatelessWidget {
  const AppTimer(
      {required this.controllerTimer,
      required this.ref,
      required this.onTimerComplete,
      super.key});

  final CountDownController controllerTimer;
  final WidgetRef ref;
  final Function() onTimerComplete;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Center(
        child: CircularCountDownTimer(
          controller: controllerTimer,
          autoStart: false,
          textStyle: AppStyles.text50WhiteBold,
          strokeWidth: 15,
          isReverse: true,
          isReverseAnimation: true,
          width: 150,
          height: 150,
          duration: ref.read(gameAdminProvider).roundInProgress == 3 ? 60 : 45,
          ringColor: AppColors.englishVioletLighter,
          fillColor: AppColors.coral,
          textFormat: CountdownTextFormat.S,
          onComplete: onTimerComplete,
        ),
      ),
    );
  }
}
