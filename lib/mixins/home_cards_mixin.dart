import 'package:asoscijacije_nove/constants/app_colors.dart';
import 'package:asoscijacije_nove/constants/app_routes.dart';
import 'package:asoscijacije_nove/constants/app_strings.dart';
import 'package:asoscijacije_nove/models/team.dart';
import 'package:asoscijacije_nove/providers/all_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  Icon determineIcon(BuildContext context, int index) {
    switch (index) {
      case 1:
        return Icon(Icons.play_arrow_rounded,
            size: MediaQuery.of(context).size.height * 0.225,
            color: AppColors.englishVioletDarker);
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

  void Function()? determineTap(
      WidgetRef ref, BuildContext context, int index) {
    switch (index) {
      case 1:
        return () {
          ref.read(playerNumberProvider.notifier).state = 4;
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
