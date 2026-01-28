import 'package:flutter/material.dart';
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
}