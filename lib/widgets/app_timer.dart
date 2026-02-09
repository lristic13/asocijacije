import 'package:asocijacije_nove/mixins/game_mixin.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import '../constants/app_colors.dart';
import '../constants/app_styles.dart';

class AppTimer extends StatefulWidget {
  const AppTimer({
    required this.controllerTimer,
    required this.ref,
    required this.onTimerComplete,
    super.key,
  });

  final CountDownController controllerTimer;
  final WidgetRef ref;
  final Function() onTimerComplete;

  @override
  State<AppTimer> createState() => _AppTimerState();
}

class _AppTimerState extends State<AppTimer> with GameMixin {
  final _beepPlayer = AudioPlayer();
  int _lastPlayedSecond = -1;

  @override
  void initState() {
    super.initState();
    _beepPlayer.setAsset('assets/sounds/beep.m4a');
  }

  @override
  void dispose() {
    _beepPlayer.dispose();
    super.dispose();
  }

  void _onTimerChanged(String timeString) {
    final seconds = int.tryParse(timeString) ?? -1;
    if (seconds <= 10 && seconds >= 0 && seconds != _lastPlayedSecond) {
      _lastPlayedSecond = seconds;
      _beepPlayer.seek(Duration.zero);
      _beepPlayer.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Center(
        child: CircularCountDownTimer(
          controller: widget.controllerTimer,
          autoStart: false,
          textStyle: AppStyles.text50WhiteBold,
          strokeWidth: 15,
          isReverse: true,
          isReverseAnimation: true,
          width: 150,
          height: MediaQuery.of(context).size.height * 0.2,
          duration: calculateRoundTime(widget.ref),
          ringColor: AppColors.englishVioletLighter,
          fillColor: AppColors.coral,
          textFormat: CountdownTextFormat.S,
          onChange: _onTimerChanged,
          onComplete: widget.onTimerComplete,
        ),
      ),
    );
  }
}
