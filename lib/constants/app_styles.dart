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

  static const TextStyle text30VioletBold = TextStyle(
    fontSize: 30,
    color: AppColors.englishViolet,
    fontWeight: FontWeight.bold,
  );
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

  static const TextStyle text50CoralBold = TextStyle(
    fontSize: 50,
    fontWeight: FontWeight.w900,
    color: AppColors.coral,
  );
  static const TextStyle text30CoralBold = TextStyle(
    fontSize: 30,
    color: AppColors.coral,
    fontWeight: FontWeight.bold,
  );

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

  static const TextStyle text15CoralBold = TextStyle(
    fontSize: 15,
    color: AppColors.coral,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle text25WhiteBold = TextStyle(
    color: AppColors.white,
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle text35WhiteBold = TextStyle(
    color: AppColors.white,
    fontSize: 35,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle text30WhiteBold = TextStyle(
    fontSize: 30,
    color: AppColors.white,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle text25WhiteDarkerBold = TextStyle(
    color: AppColors.whiteDarker,
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle text20WhiteBold = TextStyle(
    color: AppColors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle text20WhiteNormal = TextStyle(
    fontSize: 20,
    color: AppColors.white,
  );

  static const TextStyle text15WhiteDarkerNormal = TextStyle(
    fontSize: 15,
    color: AppColors.white,
  );
  static const TextStyle text15WhiteBold = TextStyle(
    fontSize: 15,
    color: AppColors.white,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle text50WhiteBold = TextStyle(
    fontSize: 50,
    fontWeight: FontWeight.w900,
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
  static const BoxDecoration containerGradientWhite = BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
        AppColors.whiteDarker,
        AppColors.white,
      ]));
}
