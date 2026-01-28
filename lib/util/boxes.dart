import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/team.dart';

class Boxes {
  static Box<Team>? getTeams() {
    try {
      return Hive.box<Team>('teams');
    } catch (e) {
      debugPrint('Error getting teams box: $e');
      return null;
    }
  }

  static Team? getTeamById(Box box, String id) {
    try {
      return box.get(id);
    } catch (e) {
      debugPrint('Error getting team by id $id: $e');
      return null;
    }
  }

  static String? getWinnerTeam(Box<Team> box) {
    try {
      final teams = box.values.toList()
        ..sort((a, b) => b.points.compareTo(a.points));
      if (teams.isEmpty) return null;

      return teams[0].key;
    } catch (e) {
      debugPrint('Error getting winner team: $e');
      return null;
    }
  }

  static bool addPoints(Box box, String teamId) {
    try {
      Team? team = getTeamById(box, teamId);
      if (team == null) return false;
      
      team.points++;
      team.save();
      return true;
    } catch (e) {
      debugPrint('Error adding points to team $teamId: $e');
      return false;
    }
  }
}
