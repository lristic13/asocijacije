import 'package:asoscijacije_nove/constants/app_colors.dart';
import 'package:asoscijacije_nove/constants/app_routes.dart';
import 'package:asoscijacije_nove/constants/app_strings.dart';
import 'package:asoscijacije_nove/models/team.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

mixin HomeCardsMixin {
  String determineText(int index) {
    switch (index) {
      case 1:
        return AppStrings.pocniIgru;
      case 2:
        return AppStrings.uputstva;
      case 0:
        return AppStrings.izlaz;
      default:
        return '';
    }
  }

  Icon determineIcon(int index) {
    switch (index) {
      case 1:
        return const Icon(Icons.play_arrow_rounded,
            size: 200, color: AppColors.englishVioletDarker);
      case 2:
        return const Icon(Icons.rule_rounded,
            size: 150, color: AppColors.englishVioletDarker);
      case 0:
        return const Icon(Icons.logout,
            size: 125, color: AppColors.englishVioletDarker);
      default:
        return const Icon(Icons.cancel);
    }
  }

  void Function()? determineTap(BuildContext context, int index) {
    switch (index) {
      case 1:
        return () {
          Navigator.of(context).pushNamed(AppRoutes.startGamePage);
        };
      case 2:
        return () {
          Navigator.of(context).pushNamed(AppRoutes.instructionsPage);
        };
      case 0:
        return () async {
          if (Hive.isBoxOpen('teams')) {
            await Hive.box<Team>('teams').close();
          }
          SystemNavigator.pop();
        };
    }
    return null;
  }
}