import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:page_transition/page_transition.dart';

import '../models/team.dart';
import '../pages/game/game_page.dart';
import '../providers/all_providers.dart';
import '../words/words.dart';

mixin FormsMixin {
  void validateForms(BuildContext context, WidgetRef ref,
      List<GlobalKey<FormBuilderState>> formKeys, Box box, int teamId) {
    for (var element in formKeys) {
      if (!element.currentState!.validate()) {
        ref.read(checkerProvider.notifier).state = false;
      } else {
        ref.read(checkerProvider.notifier).state = true;

        final formData = element.currentState?.value;
        Team team = Team(
          player1: formData!['player1'],
          player2: formData['player2'],
          points: 0,
        );

        box.put('tim-${teamId++}', team);
      }
    }
    if (ref.read(checkerProvider) && context.mounted) {
      List<String> words = [];
      ref.read(localeProvider) == const Locale('sr')
          ? words = rsWords
          : words = enWords;
      words.shuffle();
      ref.read(wordsProvider.notifier).wordsToPlay =
          words.sublist(0, ref.read(playerNumberProvider) * 8);
      Navigator.push(
          context,
          PageTransition(
              child: const GamePage(), type: PageTransitionType.leftToRight));
    }
  }
}
