import 'package:asoscijacije_nove/constants/app_routes.dart';
import 'package:asoscijacije_nove/l10n/l10n.dart';
import 'package:asoscijacije_nove/models/team.dart';
import 'package:asoscijacije_nove/pages/game/game_page.dart';
import 'package:asoscijacije_nove/pages/home/home_page.dart';
import 'package:asoscijacije_nove/pages/scoreboard/scoreboard_page.dart';
import 'package:asoscijacije_nove/pages/start_game/start_game_page.dart';
import 'package:asoscijacije_nove/providers/all_providers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TeamAdapter());
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppConsumerState();
}

class _MyAppConsumerState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final appLocale = ref.watch(localeProvider);

    return MaterialApp(
      supportedLocales: L10n.all,
      locale: appLocale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      debugShowCheckedModeBanner: false,
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
