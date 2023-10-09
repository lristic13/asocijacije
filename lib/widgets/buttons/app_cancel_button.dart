import 'package:asoscijacije_nove/mixins/game_mixin.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../app_alert_dialog.dart';
import 'base-buttons/app_button_empty.dart';

class AppCancelButton extends StatefulWidget {
  const AppCancelButton(
      {required this.timerController,
      required this.wordsToPlay,
      required this.ref,
      super.key});

  final CountDownController timerController;
  final List<String> wordsToPlay;
  final WidgetRef ref;

  @override
  State<AppCancelButton> createState() => _AppCancelButtonState();
}

class _AppCancelButtonState extends State<AppCancelButton> with GameMixin {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.timerController.getTime() != '0' &&
          widget.timerController.getTime() != '' &&
          !widget.timerController.isPaused &&
          widget.wordsToPlay.isNotEmpty,
      child: SizedBox(
        width: double.infinity,
        height: 40,
        child: AppButtonEmpty(
          borderColor: AppColors.white,
          textColor: AppColors.white,
          buttonText: AppStrings.odustani,
          textSize: 15,
          onPressed: () {
            widget.timerController.pause();
            setState(() {});
            showDialog(
              context: context,
              builder: (context) => AppAlertDialog(
                title: AppStrings.odustajete,
                content: AppStrings.odustaniAlertContent,
                onPressedNo: () {
                  Navigator.of(context).pop();
                  widget.timerController.resume();
                  setState(() {});
                },
                onPressedYes: () {
                  roundEnd(context, widget.ref);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
