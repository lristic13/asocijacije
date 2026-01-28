import 'package:hive/hive.dart';

part 'team.g.dart';

@HiveType(typeId: 0)
class Team extends HiveObject {
  Team({
    required this.teamName,
    required this.player1,
    required this.player2,
    required this.points,
  });

  @HiveField(1)
  String player1;

  @HiveField(2)
  String player2;

  @HiveField(3)
  int points;

  @HiveField(4)
  String teamName;

  @override
  String toString() {
    return 'Team($teamName: $player1, $player2, points: $points)';
  }
}
