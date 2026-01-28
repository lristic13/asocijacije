import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:page_transition/page_transition.dart';

import '../models/game_mode.dart';
import '../models/team.dart';
import '../pages/game/game_page.dart';
import '../providers/all_providers.dart';
import '../services/words_loader.dart';

mixin FormsMixin {
  Future<void> validateForms(
    BuildContext context,
    WidgetRef ref,
    List<GlobalKey<FormBuilderState>> formKeys,
    Box box,
    int teamId,
  ) async {
    for (var element in formKeys) {
      final currentState = element.currentState;
      if (currentState == null || !currentState.validate()) {
        ref.read(checkerProvider.notifier).update((state) => false);
        return; // Exit early if validation fails
      } else {
        ref.read(checkerProvider.notifier).update((state) => true);

        final formData = currentState.value;
        if (formData['player1'] != null &&
            formData['player2'] != null) {
          Team team = Team(
            player1: formData['player1'] as String,
            player2: formData['player2'] as String,
            points: 0,
          );

          box.put('tim-${teamId++}', team);
          ref.read(blurProvider.notifier).update((state) => true);
        }
      }
    }
    if (ref.read(checkerProvider) && context.mounted) {
      final localeCode =
          ref.read(localeProvider) == const Locale('sr') ? 'sr' : 'en';
      final words = await WordsLoader.loadWords(localeCode);
      words.shuffle();
      if (!context.mounted) return;
      ref.read(wordsProvider.notifier).wordsToPlay =
          words.sublist(0, ref.read(playerNumberProvider) * GameMode.wordsPerPlayer);
      Navigator.push(
          context,
          PageTransition(
              child: const GamePage(), type: PageTransitionType.leftToRight));
    }
  }

  List<GlobalKey<FormBuilderState>> generateKeys(WidgetRef ref) {
    return List.generate(ref.read(playerNumberProvider) ~/ 2,
        (i) => GlobalKey<FormBuilderState>());
  }
}
