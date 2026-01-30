import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../models/session_state.dart';

class WordCollectionService {
  final DatabaseReference _database = FirebaseDatabase.instanceFor(
    app: FirebaseDatabase.instance.app,
    databaseURL: 'https://asocijacije-2ab22-default-rtdb.europe-west1.firebasedatabase.app',
  ).ref();

  /// Characters for session ID (excluding ambiguous chars like 0/O, 1/I/L)
  static const _chars = 'ABCDEFGHJKMNPQRSTUVWXYZ23456789';

  /// Create a new word collection session
  Future<String> createSession(int playerCount, String hostId) async {
    // Clean up old sessions first (fire and forget)
    _cleanupOldSessions();

    try {
      final sessionId = _generateSessionId();
      final sessionRef = _database.child('sessions/$sessionId');

      // Check if session already exists (rare collision)
      final snapshot = await sessionRef.get();
      if (snapshot.exists) {
        // Recursively try again with new ID
        return createSession(playerCount, hostId);
      }

      // Create session
      await sessionRef.set({
        'createdAt': ServerValue.timestamp,
        'hostId': hostId,
        'playerCount': playerCount,
        'status': 'collecting',
        'expiresAt':
            DateTime.now().add(const Duration(minutes: 30)).millisecondsSinceEpoch,
        'targetWords': playerCount * 8,
        'words': {},
      });

      debugPrint('Session created: $sessionId');
      return sessionId;
    } catch (e) {
      debugPrint('Error creating session: $e');
      rethrow;
    }
  }

  /// Generate readable 6-character session ID
  String _generateSessionId() {
    final random = const Uuid().v4().hashCode;
    String id = '';
    var value = random.abs();

    for (int i = 0; i < 6; i++) {
      id += _chars[value % _chars.length];
      value ~/= _chars.length;
    }

    return id;
  }

  /// Listen to word submissions in real-time
  Stream<SessionState> watchSession(String sessionId) {
    return _database.child('sessions/$sessionId').onValue.map((event) {
      if (!event.snapshot.exists) {
        return SessionState.empty(sessionId);
      }

      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      return SessionState.fromMap(sessionId, data);
    });
  }

  /// Collect all words from a session
  Future<List<String>> collectWords(String sessionId) async {
    final snapshot = await _database.child('sessions/$sessionId/words').get();

    if (!snapshot.exists) return [];

    final List<String> allWords = [];
    final wordsData = Map<String, dynamic>.from(snapshot.value as Map);

    wordsData.forEach((playerId, playerData) {
      final playerMap = Map<String, dynamic>.from(playerData as Map);
      final words = List<String>.from(playerMap['words'] as List);
      allWords.addAll(words);
    });

    return allWords;
  }

  /// Close session and mark as completed
  Future<void> closeSession(String sessionId) async {
    await _database.child('sessions/$sessionId/status').set('completed');
  }

  /// Delete session (cleanup)
  Future<void> deleteSession(String sessionId) async {
    await _database.child('sessions/$sessionId').remove();
  }

  /// Submit words for a player (used by host to add their own words)
  Future<void> submitWords({
    required String sessionId,
    required String playerId,
    required List<String> words,
    String? playerName,
  }) async {
    final ref = _database.child('sessions/$sessionId/words/$playerId');
    await ref.set({
      'words': words,
      'submittedAt': ServerValue.timestamp,
      'playerName': playerName,
    });
  }

  /// Check if session exists and is still collecting
  Future<bool> isSessionValid(String sessionId) async {
    final snapshot = await _database.child('sessions/$sessionId').get();
    if (!snapshot.exists) return false;

    final data = Map<String, dynamic>.from(snapshot.value as Map);
    final status = data['status'] as String?;
    final expiresAt = data['expiresAt'] as int?;

    if (status != 'collecting') return false;
    if (expiresAt != null && DateTime.now().millisecondsSinceEpoch > expiresAt) {
      return false;
    }

    return true;
  }

  /// Clean up expired and completed sessions
  Future<void> _cleanupOldSessions() async {
    try {
      final snapshot = await _database.child('sessions').get();
      if (!snapshot.exists) return;

      final now = DateTime.now().millisecondsSinceEpoch;
      final sessions = Map<String, dynamic>.from(snapshot.value as Map);

      for (final entry in sessions.entries) {
        final sessionId = entry.key;
        final data = Map<String, dynamic>.from(entry.value as Map);

        final status = data['status'] as String?;
        final expiresAt = data['expiresAt'] as int?;

        // Delete if expired or completed
        final isExpired = expiresAt != null && now > expiresAt;
        final isCompleted = status == 'completed';

        if (isExpired || isCompleted) {
          await _database.child('sessions/$sessionId').remove();
          debugPrint('Cleaned up session: $sessionId (expired: $isExpired, completed: $isCompleted)');
        }
      }
    } catch (e) {
      debugPrint('Error cleaning up sessions: $e');
      // Don't rethrow - cleanup is best-effort
    }
  }
}
