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
    notifyListeners();
  }
}
