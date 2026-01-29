import 'package:asocijacije_nove/constants/app_routes.dart';
import 'package:asocijacije_nove/l10n/app_localizations.dart';
import 'package:asocijacije_nove/l10n/l10n.dart';
import 'package:asocijacije_nove/models/team.dart';
import 'package:asocijacije_nove/pages/game/game_page.dart';
import 'package:asocijacije_nove/pages/home/home_page.dart';
import 'package:asocijacije_nove/pages/instructions/instructions_page.dart';
import 'package:asocijacije_nove/pages/scoreboard/scoreboard_page.dart';
import 'package:asocijacije_nove/pages/start_game/start_game_page.dart';
import 'package:asocijacije_nove/providers/all_providers.dart';
import 'package:asocijacije_nove/services/navigation_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TeamAdapter());

  try {
    await Firebase.initializeApp(
      name: 'asocijacije',
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
  }

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
      navigatorKey: NavigationService.navigatorKey,
      supportedLocales: L10n.all,
      locale: appLocale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, fontFamily: 'Geologica'),
      home: const HomePage(),
      routes: {
        AppRoutes.gamePage: (context) => const GamePage(),
        AppRoutes.homePage: (context) => const HomePage(),
        AppRoutes.startGamePage: (context) => const StartGamePage(),
        AppRoutes.scoreboardPage: (context) => const ScoreBoardPage(),
        AppRoutes.instructionsPage: (context) => const InstructionsPage(),
      },
    );
  }
}
