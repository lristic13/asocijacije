import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_styles.dart';

class AppExplainingColumn extends StatelessWidget {
  const AppExplainingColumn(
      {required this.playerExplaining,
      required this.player1,
      required this.player2,
      super.key});

  final int playerExplaining;
  final String player1;
  final String player2;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            playerExplaining == 1 ? player1 : player2,
            style: AppStyles.text25WhiteBold,
          ),
          const Icon(Icons.arrow_downward_outlined,
              color: AppColors.coral, size: 30),
          Text(
            playerExplaining == 1 ? player2 : player1,
            style: AppStyles.text25WhiteBold,
          )
        ],
      ),
    );
  }
}
