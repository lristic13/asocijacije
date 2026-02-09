import 'package:asocijacije_nove/models/game_mode.dart';
import 'package:asocijacije_nove/pages/one_vs_one/one_vs_one_scoreboard_page.dart';
import 'package:asocijacije_nove/providers/all_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import '../constants/app_routes.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  static BuildContext? get context => navigatorKey.currentContext;
  
  static Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    final navigator = navigatorKey.currentState;
    if (navigator == null) {
      debugPrint('NavigationService: Navigator is null');
      return Future.value(null);
    }
    return navigator.pushNamed<T>(routeName, arguments: arguments);
  }
  
  static Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String newRouteName,
    RoutePredicate predicate, {
    Object? arguments,
  }) {
    final navigator = navigatorKey.currentState;
    if (navigator == null) {
      debugPrint('NavigationService: Navigator is null');
      return Future.value(null);
    }
    return navigator.pushNamedAndRemoveUntil<T>(
      newRouteName, 
      predicate, 
      arguments: arguments,
    );
  }
  
  static void pop<T extends Object?>([T? result]) {
    final navigator = navigatorKey.currentState;
    if (navigator == null) {
      debugPrint('NavigationService: Navigator is null');
      return;
    }
    if (navigator.canPop()) {
      navigator.pop<T>(result);
    }
  }
  
  static bool canPop() {
    final navigator = navigatorKey.currentState;
    return navigator?.canPop() ?? false;
  }
  
  // Game-specific navigation helpers
  static Future<void> goToHome() {
    return pushNamedAndRemoveUntil(AppRoutes.homePage, (route) => false);
  }
  
  static Future<void> goToScoreboard() {
    return pushNamedAndRemoveUntil(AppRoutes.scoreboardPage, (route) => false);
  }
  
  static Future<void> goToStartGame() {
    return pushNamed(AppRoutes.startGamePage);
  }
  
  static Future<void> goToInstructions() {
    return pushNamed(AppRoutes.instructionsPage);
  }

  static Future<void> goToOneVsOneResults() {
    return pushNamedAndRemoveUntil(AppRoutes.oneVsOneResultsPage, (route) => false);
  }

  static void goTo1v1Scoreboard(WidgetRef ref) {
    final currentRound = ref.read(gameAdminProvider).roundInProgress;

    // Check if game is over (going to round 4 which is final)
    if (currentRound >= GameMode.finalRound) {
      goToOneVsOneResults();
      return;
    }

    final navigator = navigatorKey.currentState;
    if (navigator == null) {
      debugPrint('NavigationService: Navigator is null');
      return;
    }
    navigator.pushAndRemoveUntil(
      PageTransition(
        child: const OneVsOneScoreboardPage(),
        type: PageTransitionType.fade,
      ),
      (route) => false,
    );
  }
}