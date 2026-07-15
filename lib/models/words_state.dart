import 'package:flutter/material.dart';

class WordsState extends ChangeNotifier {
  WordsState({required this.usedWords, required this.wordsToPlay});
  List<String> wordsToPlay;
  List<String> usedWords;

  void addWord(String word) {
    usedWords.add(word);
    notifyListeners();
  }

  void removeWord(String word) {
    wordsToPlay.removeWhere((w) => w == word);
    notifyListeners();
  }

  void refreshWords() {
    usedWords.shuffle();
    wordsToPlay.addAll(usedWords);
    // Recycle the same pool each round — clear the guessed list so words don't
    // accumulate and double the pool size every round.
    usedWords.clear();
    notifyListeners();
  }

  void resetWords() {
    usedWords.clear();
    wordsToPlay.clear();
    notifyListeners();
  }
}
