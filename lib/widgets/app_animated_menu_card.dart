import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import 'cards/menu_card.dart';

class AppAnimatedMenuCard extends StatelessWidget {
  const AppAnimatedMenuCard(
      {required this.menuCardTitle,
      required this.menuCardIcon,
      required this.targetPage,
      super.key});

  final String menuCardTitle;
  final Icon menuCardIcon;
  final Widget targetPage;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      middleColor: Colors.transparent,
      closedElevation: 0,
      closedColor: Colors.transparent,
      openColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 750),
      openBuilder: (context, _) => targetPage,
      closedBuilder: (context, action) => MenuCard(
        title: menuCardTitle,
        icon: menuCardIcon,
        colors: const [
          AppColors.englishVioletDarker,
          AppColors.englishViolet,
        ],
        alignment: menuCardTitle == AppStrings.uputstvaZaIgru
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        rowAlignment: menuCardTitle == AppStrings.uputstvaZaIgru
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        onTap: action,
      ),
    );
  }
}
