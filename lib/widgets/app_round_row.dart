import 'package:asocijacije_nove/constants/app_colors.dart';
import 'package:asocijacije_nove/constants/app_styles.dart';
import 'package:flutter/material.dart';

/// A small round-timer tile: the duration (cyan) over the round name. Designed
/// to sit inside an [Expanded] in a row of three.
class AppRoundRow extends StatelessWidget {
  const AppRoundRow({
    super.key,
    required this.roundName,
    required this.roundLength,
  });
  final String roundName;
  final int roundLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${roundLength}s',
            style: NeonText.display(size: 17, color: AppColors.cyan),
          ),
          const SizedBox(height: 2),
          Text(
            roundName,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: NeonText.body(
              size: 10,
              weight: FontWeight.w700,
              color: AppColors.sub,
            ),
          ),
        ],
      ),
    );
  }
}
