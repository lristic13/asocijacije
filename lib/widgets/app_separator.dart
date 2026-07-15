import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

/// The short underline bar that sits beneath a [AppPageHeader] — 40×5 with a
/// soft accent glow.
class AppSeparator extends StatelessWidget {
  const AppSeparator({this.color, this.width = 40, super.key});
  final Color? color;
  final double width;

  @override
  Widget build(BuildContext context) {
    final barColor = color ?? AppColors.orange;
    return Container(
      margin: const EdgeInsets.only(top: 4),
      height: 5,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: barColor,
        boxShadow: [
          BoxShadow(
            color: barColor.withValues(alpha: 0.6),
            blurRadius: 12,
          ),
        ],
      ),
    );
  }
}
