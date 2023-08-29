import 'package:asoscijacije_nove/models/words_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/game_state.dart';

final playerNumberProvider = StateProvider<int>((ref) => 4);

final gameAdminProvider = StateProvider<GameState>((ref) => GameState());

final wordsProvider = ChangeNotifierProvider<WordsState>(
    (ref) => WordsState(usedWords: [], wordsToPlay: []));

final checkerProvider = StateProvider<bool>((ref) => false);
