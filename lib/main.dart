import 'package:asocijacije_nove/constants/app_routes.dart';
import 'package:asocijacije_nove/constants/feature_flags.dart';
import 'package:asocijacije_nove/l10n/app_localizations.dart';
import 'package:asocijacije_nove/l10n/l10n.dart';
import 'package:asocijacije_nove/models/team.dart';
import 'package:asocijacije_nove/pages/game/game_page.dart';
import 'package:asocijacije_nove/pages/home/home_page.dart';
import 'package:asocijacije_nove/pages/instructions/instructions_page.dart';
import 'package:asocijacije_nove/pages/scoreboard/scoreboard_page.dart';
import 'package:asocijacije_nove/pages/start_game/start_game_page.dart';
import 'package:asocijacije_nove/pages/one_vs_one/one_vs_one_results_page.dart';
import 'package:asocijacije_nove/pages/paywall/paywall_page.dart';
import 'package:asocijacije_nove/pages/word_collection/word_collection_page.dart';
import 'package:asocijacije_nove/pages/word_source/word_source_page.dart';
import 'package:asocijacije_nove/providers/all_providers.dart';
import 'package:asocijacije_nove/services/navigation_service.dart';
import 'package:asocijacije_nove/services/purchase_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../firebase_options.dart';
import '../constants/app_colors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TeamAdapter());

  // Entitlement cache so the pro unlock works offline; stays open for the
  // whole app lifetime (unlike the teams box).
  final settingsBox = await Hive.openBox<bool>('settings');
  final cachedPro = settingsBox.get('isPro') ?? false;

  try {
    await Firebase.initializeApp(
      name: 'asocijacije',
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
  }

  runApp(
    ProviderScope(
      overrides: [
        proProvider.overrideWith((ref) => cachedPro),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppConsumerState();
}

class _MyAppConsumerState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    if (FeatureFlags.paywallEnabled) {
      PurchaseService.init(
        onProChanged: (isPro) {
          Hive.box<bool>('settings').put('isPro', isPro);
          ref.read(proProvider.notifier).state = isPro;
        },
      );
    }
  }

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
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.bg,
        textTheme: GoogleFonts.hankenGroteskTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
        colorScheme: const ColorScheme.dark(
          surface: AppColors.bg,
          primary: AppColors.orange,
          secondary: AppColors.cyan,
        ),
      ),
      home: const HomePage(),
      routes: {
        AppRoutes.gamePage: (context) => const GamePage(),
        AppRoutes.homePage: (context) => const HomePage(),
        AppRoutes.startGamePage: (context) => const StartGamePage(),
        AppRoutes.scoreboardPage: (context) => const ScoreBoardPage(),
        AppRoutes.instructionsPage: (context) => const InstructionsPage(),
        AppRoutes.wordCollectionPage: (context) => const WordCollectionPage(),
        AppRoutes.wordSourcePage: (context) => const WordSourcePage(),
        AppRoutes.oneVsOneResultsPage: (context) => const OneVsOneResultsPage(),
        AppRoutes.paywallPage: (context) => const PaywallPage(),
      },
    );
  }
}
