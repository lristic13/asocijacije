import 'package:asoscijacije_nove/models/words_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/game_state.dart';

final playerNumberProvider = StateProvider<int>((ref) => 4);

final gameAdminProvider = StateProvider<GameState>((ref) => GameState());

final wordsProvider = ChangeNotifierProvider<WordsState>(
    (ref) => WordsState(usedWords: [], wordsToPlay: []));

final checkerProvider = StateProvider<bool>((ref) => false);

final localeProvider = StateProvider<Locale>((ref) => const Locale('sr'));
final blurProvider = StateProvider<bool>((ref) => true);

final gameModeProvider = StateProvider<String>((ref) => 'Normalan');
