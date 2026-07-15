import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_styles.dart';

/// Turn caption — "Player 1 → Player 2" with an orange arrow.
class AppExplainingRow extends StatelessWidget {
  const AppExplainingRow(
      {required this.playerExplaining,
      required this.player1,
      required this.player2,
      super.key});

  final int playerExplaining;
  final String player1;
  final String player2;

  @override
  Widget build(BuildContext context) {
    final style = NeonText.body(
      size: 13,
      weight: FontWeight.w700,
      color: AppColors.sub,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(playerExplaining == 1 ? player1 : player2, style: style),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Icon(Icons.arrow_right_alt_rounded,
              color: AppColors.orange, size: 20),
        ),
        Text(playerExplaining == 1 ? player2 : player1, style: style),
      ],
    );
  }
}
