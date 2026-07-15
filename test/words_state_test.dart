import 'package:asocijacije_nove/models/words_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('pool recycles at constant size across rounds (no doubling)', () {
    final state = WordsState(
      usedWords: [],
      wordsToPlay: List.generate(32, (i) => 'w$i'),
    );

    final sizesAtRoundStart = <int>[];
    for (var round = 1; round <= 3; round++) {
      sizesAtRoundStart.add(state.wordsToPlay.length);
      // Guess every word this round: move each from play -> used.
      while (state.wordsToPlay.isNotEmpty) {
        final w = state.wordsToPlay.first;
        state.addWord(w);
        state.removeWord(w);
      }
      expect(state.wordsToPlay, isEmpty);
      state.refreshWords(); // end-of-round recycle
    }

    // Before fix this was [32, 64, 128]; after fix it must stay flat.
    expect(sizesAtRoundStart, [32, 32, 32]);
    expect(state.usedWords, isEmpty);
  });
}
