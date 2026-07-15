import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

/// The signature Neon Arcade backdrop: the deep-indigo [AppColors.bg] base with
/// three soft radial glows (orange top-left, cyan bottom-right, magenta
/// top-right) layered on top. Use as the root of every screen.
class NeonBackground extends StatelessWidget {
  const NeonBackground({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: AppColors.bg),
      child: Stack(
        children: [
          _glow(
            const Alignment(-0.7, -1.05),
            AppColors.orange.withValues(alpha: 0.22),
            1.2,
          ),
          _glow(
            const Alignment(0.9, 1.05),
            AppColors.cyan.withValues(alpha: 0.16),
            1.2,
          ),
          _glow(
            const Alignment(0.9, -1.0),
            AppColors.magenta.withValues(alpha: 0.14),
            0.9,
          ),
          Positioned.fill(child: child),
        ],
      ),
    );
  }

  Widget _glow(Alignment center, Color color, double radius) {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: center,
            radius: radius,
            colors: [color, color.withValues(alpha: 0)],
            stops: const [0.0, 0.55],
          ),
        ),
      ),
    );
  }
}
