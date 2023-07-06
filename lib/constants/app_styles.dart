import 'package:asoscijacije_nove/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppStyles {
  // Text styles
  static const TextStyle text40VioletBold = TextStyle(
      color: AppColors.englishViolet,
      fontSize: 40,
      fontWeight: FontWeight.bold);

  static const TextStyle text25Violet900 = TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w900,
      color: AppColors.englishVioletDarker);

  static const TextStyle text25VioletBold = TextStyle(
    fontSize: 25,
    color: AppColors.englishViolet,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle text20VioletBold = TextStyle(
      color: AppColors.englishViolet,
      fontSize: 20,
      fontWeight: FontWeight.bold);

  static const TextStyle text20VioletDarkerBold = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.englishVioletDarker);

  static const TextStyle text25CoralBold = TextStyle(
    fontSize: 25,
    color: AppColors.coral,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle text20CoralBold = TextStyle(
    fontSize: 20,
    color: AppColors.coral,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle text25WhiteBold = TextStyle(
    color: AppColors.white,
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle text35WhiteDarkerBold = TextStyle(
    color: AppColors.white,
    fontSize: 35,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle text30WhiteDarkerbold = TextStyle(
    fontSize: 30,
    color: AppColors.white,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle text25WhiteDarkerBold = TextStyle(
    color: AppColors.whiteDarker,
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle text20WhiteDarkerBold = TextStyle(
    color: AppColors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle text20WhiteDarkerNormal = TextStyle(
    fontSize: 20,
    color: AppColors.white,
  );

  static const TextStyle text15WhiteDarkerNormal = TextStyle(
    fontSize: 15,
    color: AppColors.white,
  );

  // Container
  static const BoxDecoration containerGradientViolet = BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
        AppColors.englishVioletDarker,
        AppColors.englishVioletLighter,
      ]));
}
