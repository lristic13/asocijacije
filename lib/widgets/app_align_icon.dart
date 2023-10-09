import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppAlignIcon extends StatelessWidget {
  const AppAlignIcon({required this.align, required this.icon, super.key});

  final Alignment align;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: align,
      child: Container(
        transform: Matrix4.translationValues(-25, -45.0, 0.0),
        child: ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (Rect bounds) => const RadialGradient(
            center: Alignment.topCenter,
            stops: [.2, 1],
            colors: [
              AppColors.white,
              AppColors.whiteDarker,
            ],
          ).createShader(bounds),
          child: icon,
        ),
      ),
    );
  }
}
