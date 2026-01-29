import 'package:asocijacije_nove/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppStyles {
  // Text styles
  static const TextStyle text40VioletBold = TextStyle(
    color: AppColors.englishViolet,
    fontSize: 40,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle text25Violet900 = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w900,
    color: AppColors.englishVioletDarker,
  );
  static const TextStyle text30VioletDarkerBold = TextStyle(
    fontSize: 30,
    color: AppColors.englishVioletDarker,
    fontWeight: FontWeight.bold,
  );

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
    fontWeight: FontWeight.bold,
  );
  static const TextStyle text25VioletDarkerBold = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
    color: AppColors.englishVioletDarker,
  );

  static const TextStyle text20VioletDarkerBold = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.englishVioletDarker,
  );

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

  static const TextStyle text45WhiteBold = TextStyle(
    color: AppColors.white,
    fontSize: 45,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle text40WhiteBold = TextStyle(
    color: AppColors.white,
    fontSize: 40,
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

  static const TextStyle text15WhiteNormal = TextStyle(
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
  static const TextStyle text60VioletLighterBold = TextStyle(
    fontSize: 60,
    fontWeight: FontWeight.w800,
    color: AppColors.englishVioletLighter,
  );

  // Container
  static const BoxDecoration containerGradientViolet = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppColors.englishVioletDarker, AppColors.englishVioletLighter],
    ),
  );
  static const BoxDecoration containerGradientWhite = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppColors.whiteDarker, AppColors.white],
    ),
  );

  // Input fields
  static final focusedErrorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(13),
    borderSide: const BorderSide(color: AppColors.coral, width: 3),
  );

  static final errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(13),
    borderSide: const BorderSide(color: AppColors.coral, width: 3),
  );

  static final enabledBorder = OutlineInputBorder(
    borderSide: const BorderSide(
      color: AppColors.englishVioletMoreLighter,
      width: 1.5,
    ),
    borderRadius: BorderRadius.circular(13),
  );

  static final focusedBorder = OutlineInputBorder(
    borderSide: const BorderSide(
      color: AppColors.englishVioletMoreLighter,
      width: 3,
    ),
    borderRadius: BorderRadius.circular(13),
  );

  static final errorInputDecoration = InputDecoration(
    focusedErrorBorder: AppStyles.focusedErrorBorder,
    errorBorder: AppStyles.errorBorder,
    labelStyle: const TextStyle(color: AppColors.white),
    errorStyle: const TextStyle(color: AppColors.coral, fontSize: 10),
    contentPadding: const EdgeInsets.only(left: 10),
    enabledBorder: AppStyles.enabledBorder,
    focusedBorder: AppStyles.focusedBorder,
  );
}
