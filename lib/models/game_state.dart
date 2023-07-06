class GameState {
  GameState({
    this.teamPlaying = 1,
    this.playerExplaining = 1,
    this.roundInProgress = 1,
    this.allWordsGuessed = false,
  });

  int teamPlaying;
  int playerExplaining;
  int roundInProgress;
  bool allWordsGuessed;

  void resetGame() {
    playerExplaining = 1;
    teamPlaying = 1;
    roundInProgress = 1;
    allWordsGuessed = false;
  }
}
