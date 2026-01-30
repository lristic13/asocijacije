import 'player_submission.dart';

class SessionState {
  final String sessionId;
  final int playerCount;
  final int targetWords;
  final Map<String, PlayerSubmission> submissions;
  final int totalWords;
  final int playersReady;
  final bool isReady;
  final String status;

  SessionState({
    required this.sessionId,
    required this.playerCount,
    required this.targetWords,
    required this.submissions,
    this.totalWords = 0,
    this.playersReady = 0,
    this.isReady = false,
    this.status = 'collecting',
  });

  factory SessionState.empty(String sessionId) {
    return SessionState(
      sessionId: sessionId,
      playerCount: 0,
      targetWords: 0,
      submissions: {},
      isReady: false,
    );
  }

  factory SessionState.fromMap(String sessionId, Map<String, dynamic> data) {
    final playerCount = data['playerCount'] as int;
    final targetWords = data['targetWords'] as int;
    final status = data['status'] as String? ?? 'collecting';

    // Parse submissions
    final Map<String, PlayerSubmission> submissions = {};
    if (data.containsKey('words') && data['words'] != null) {
      final wordsData = Map<String, dynamic>.from(data['words'] as Map);
      wordsData.forEach((playerId, playerData) {
        final playerMap = Map<String, dynamic>.from(playerData as Map);
        submissions[playerId] = PlayerSubmission.fromMap(playerId, playerMap);
      });
    }

    // Calculate totals
    int totalWords = 0;
    int playersReady = 0;
    submissions.forEach((_, submission) {
      totalWords += submission.words.length;
      if (submission.isComplete) playersReady++;
    });

    final isReady = playersReady == playerCount && totalWords == targetWords;

    return SessionState(
      sessionId: sessionId,
      playerCount: playerCount,
      targetWords: targetWords,
      submissions: submissions,
      totalWords: totalWords,
      playersReady: playersReady,
      isReady: isReady,
      status: status,
    );
  }
}
