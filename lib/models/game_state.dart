class GameState {
  const GameState({
    this.teamPlaying = 1,
    this.playerExplaining = 1,
    this.roundInProgress = 1,
    this.allWordsGuessed = false,
  });

  final int teamPlaying;
  final int playerExplaining;
  final int roundInProgress;
  final bool allWordsGuessed;

  GameState copyWith({
    int? teamPlaying,
    int? playerExplaining,
    int? roundInProgress,
    bool? allWordsGuessed,
  }) {
    return GameState(
      teamPlaying: teamPlaying ?? this.teamPlaying,
      playerExplaining: playerExplaining ?? this.playerExplaining,
      roundInProgress: roundInProgress ?? this.roundInProgress,
      allWordsGuessed: allWordsGuessed ?? this.allWordsGuessed,
    );
  }

  GameState resetGame() {
    return const GameState(
      teamPlaying: 1,
      playerExplaining: 1,
      roundInProgress: 1,
      allWordsGuessed: false,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GameState &&
        other.teamPlaying == teamPlaying &&
        other.playerExplaining == playerExplaining &&
        other.roundInProgress == roundInProgress &&
        other.allWordsGuessed == allWordsGuessed;
  }

  @override
  int get hashCode {
    return teamPlaying.hashCode ^
        playerExplaining.hashCode ^
        roundInProgress.hashCode ^
        allWordsGuessed.hashCode;
  }
}
