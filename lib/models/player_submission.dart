class PlayerSubmission {
  final String playerId;
  final List<String> words;
  final DateTime submittedAt;
  final String? playerName;

  PlayerSubmission({
    required this.playerId,
    required this.words,
    required this.submittedAt,
    this.playerName,
  });

  factory PlayerSubmission.fromMap(String playerId, Map<String, dynamic> map) {
    return PlayerSubmission(
      playerId: playerId,
      words: List<String>.from(map['words'] as List),
      submittedAt: DateTime.fromMillisecondsSinceEpoch(map['submittedAt'] as int),
      playerName: map['playerName'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'words': words,
      'submittedAt': submittedAt.millisecondsSinceEpoch,
      if (playerName != null) 'playerName': playerName,
    };
  }

  bool get isComplete => words.length == 8;
}
