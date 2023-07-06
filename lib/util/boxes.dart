import 'package:hive_flutter/hive_flutter.dart';

import '../models/team.dart';

class Boxes {
  static Box<Team> getTeams() => Hive.box<Team>('teams');

  static Team getTeamById(Box box, String id) => box.get(id);

  static String getWinnerTeam(Box<Team> box) {
    List<Team> teams = box.values.toList();
    teams.sort((b, a) => a.points.compareTo(b.points));

    return teams[0].key;
  }

  static void addPoints(Box box, String teamId) {
    Team team = getTeamById(box, teamId);
    team.points++;
    team.save();
  }
}
