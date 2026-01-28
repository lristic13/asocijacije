enum GameMode {
  normal,
  quick;

  static const int normalRound1And2Duration = 45;
  static const int normalRound3Duration = 60;
  static const int quickRound1And2Duration = 30;
  static const int quickRound3Duration = 45;
  static const int wordsPerPlayer = 8;
  static const int finalRound = 4;

  static const int normalDoublePointsThreshold = 10;
  static const int quickDoublePointsThreshold = 7;
  static const int normalMimeDoublePointsThreshold = 15;
  static const int quickMimeDoublePointsThreshold = 10;
}
