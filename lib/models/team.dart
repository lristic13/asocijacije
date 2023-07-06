import 'package:hive/hive.dart';

part 'team.g.dart';

@HiveType(typeId: 0)
class Team extends HiveObject {
  Team({
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

  @override
  String toString() {
    return 'Team($player1, $player2, points: $points)';
  }
}
