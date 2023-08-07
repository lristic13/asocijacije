import 'package:asoscijacije_nove/constants/app_routes.dart';
import 'package:asoscijacije_nove/models/team.dart';
import 'package:asoscijacije_nove/pages/game/game_page.dart';
import 'package:asoscijacije_nove/pages/home/home_page.dart';
import 'package:asoscijacije_nove/pages/scoreboard/scoreboard_page.dart';
import 'package:asoscijacije_nove/pages/start_game/start_game_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TeamAdapter());
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Geologica',
      ),
      home: const HomePage(),
      routes: {
        AppRoutes.gamePage: (context) => const GamePage(),
        AppRoutes.homePage: (context) => const HomePage(),
        AppRoutes.startGamePage: (context) => const StartGamePage(),
        AppRoutes.scoreboardPage: (context) => const ScoreBoardPage(),
      },
    );
  }
}
