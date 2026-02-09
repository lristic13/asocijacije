class OneVsOneState {
  const OneVsOneState({
    this.player1Name = 'Player 1',
    this.player2Name = 'Player 2',
    this.player1Score = 0,
    this.player2Score = 0,
    this.currentPlayer = 1,
  });

  final String player1Name;
  final String player2Name;
  final int player1Score;
  final int player2Score;
  final int currentPlayer;

  static const int wordsPerPlayer = 15;

  OneVsOneState copyWith({
    String? player1Name,
    String? player2Name,
    int? player1Score,
    int? player2Score,
    int? currentPlayer,
  }) {
    return OneVsOneState(
      player1Name: player1Name ?? this.player1Name,
      player2Name: player2Name ?? this.player2Name,
      player1Score: player1Score ?? this.player1Score,
      player2Score: player2Score ?? this.player2Score,
      currentPlayer: currentPlayer ?? this.currentPlayer,
    );
  }

  OneVsOneState addPointToCurrentPlayer({int points = 1}) {
    if (currentPlayer == 1) {
      return copyWith(player1Score: player1Score + points);
    } else {
      return copyWith(player2Score: player2Score + points);
    }
  }

  OneVsOneState switchPlayer() {
    return copyWith(currentPlayer: currentPlayer == 1 ? 2 : 1);
  }

  OneVsOneState resetScores() {
    return copyWith(
      player1Score: 0,
      player2Score: 0,
      currentPlayer: 1,
    );
  }

  OneVsOneState reset() {
    return const OneVsOneState();
  }

  String get currentPlayerName =>
      currentPlayer == 1 ? player1Name : player2Name;

  String get winnerName {
    if (player1Score > player2Score) return player1Name;
    if (player2Score > player1Score) return player2Name;
    return ''; // Tie
  }

  bool get isTie => player1Score == player2Score;

  int get scoreDifference => (player1Score - player2Score).abs();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OneVsOneState &&
        other.player1Name == player1Name &&
        other.player2Name == player2Name &&
        other.player1Score == player1Score &&
        other.player2Score == player2Score &&
        other.currentPlayer == currentPlayer;
  }

  @override
  int get hashCode {
    return player1Name.hashCode ^
        player2Name.hashCode ^
        player1Score.hashCode ^
        player2Score.hashCode ^
        currentPlayer.hashCode;
  }
}
