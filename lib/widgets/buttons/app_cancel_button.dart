import 'package:asocijacije_nove/l10n/app_localizations.dart';
import 'package:asocijacije_nove/mixins/game_mixin.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/app_colors.dart';

import '../app_alert_dialog.dart';
import 'base-buttons/app_button_empty.dart';

class AppCancelButton extends StatefulWidget {
  const AppCancelButton({
    required this.timerController,
    required this.wordsToPlay,
    required this.ref,
    super.key,
  });

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
      visible:
          widget.timerController.getTime() != '0' &&
          widget.timerController.getTime() != '' &&
          widget.wordsToPlay.isNotEmpty,
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.06,
        child: AppButtonEmpty(
          borderColor: AppColors.white,
          textColor: AppColors.white,
          buttonText: AppLocalizations.of(context)!.odustani,
          onPressed: () {
            widget.timerController.pause();
            setState(() {});
            showModalBottomSheet(
              context: context,
              builder: (context) => AppAlertDialog(
                title: AppLocalizations.of(context)!.odustajete,
                content: AppLocalizations.of(context)!.odustaniAlertContent,
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
