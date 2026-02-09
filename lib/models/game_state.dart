class GameState {
  const GameState({
    this.teamPlaying = 1,
    this.playerExplaining = 1,
    this.roundInProgress = 1,
    this.allWordsGuessed = false,
    this.is1v1Mode = false,
  });

  final int teamPlaying;
  final int playerExplaining;
  final int roundInProgress;
  final bool allWordsGuessed;
  final bool is1v1Mode;

  GameState copyWith({
    int? teamPlaying,
    int? playerExplaining,
    int? roundInProgress,
    bool? allWordsGuessed,
    bool? is1v1Mode,
  }) {
    return GameState(
      teamPlaying: teamPlaying ?? this.teamPlaying,
      playerExplaining: playerExplaining ?? this.playerExplaining,
      roundInProgress: roundInProgress ?? this.roundInProgress,
      allWordsGuessed: allWordsGuessed ?? this.allWordsGuessed,
      is1v1Mode: is1v1Mode ?? this.is1v1Mode,
    );
  }

  GameState resetGame() {
    return const GameState(
      teamPlaying: 1,
      playerExplaining: 1,
      roundInProgress: 1,
      allWordsGuessed: false,
      is1v1Mode: false,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GameState &&
        other.teamPlaying == teamPlaying &&
        other.playerExplaining == playerExplaining &&
        other.roundInProgress == roundInProgress &&
        other.allWordsGuessed == allWordsGuessed &&
        other.is1v1Mode == is1v1Mode;
  }

  @override
  int get hashCode {
    return teamPlaying.hashCode ^
        playerExplaining.hashCode ^
        roundInProgress.hashCode ^
        allWordsGuessed.hashCode ^
        is1v1Mode.hashCode;
  }
}
