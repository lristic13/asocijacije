import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_styles.dart';

/// Primary "lip + glow" button (legacy API kept). The fill acts as the accent;
/// the lip + colored glow are derived from it. Depresses on press — translates
/// down 3px and shrinks the lip from 5px to 2px to feel physically keyed.
class AppButtonFull extends StatefulWidget {
  const AppButtonFull({
    required this.fillColor,
    required this.textColor,
    required this.onPressed,
    required this.buttonText,
    this.fontSize = 21,
    super.key,
  });

  final Color? fillColor;
  final Color? textColor;
  final String? buttonText;
  final double fontSize;
  final void Function()? onPressed;

  @override
  State<AppButtonFull> createState() => _AppButtonFullState();
}

class _AppButtonFullState extends State<AppButtonFull> {
  bool _pressed = false;

  void _setPressed(bool v) {
    if (_pressed != v) setState(() => _pressed = v);
  }

  @override
  Widget build(BuildContext context) {
    final fill = widget.fillColor ?? AppColors.orange;
    // Prefer the exact handoff lip tokens for the two canonical accents; fall
    // back to a darkened fill for any other color.
    final lip = fill == AppColors.orange
        ? AppColors.orangeLip
        : fill == AppColors.cyan
            ? AppColors.cyanLip
            : Color.lerp(fill, Colors.black, 0.28)!;
    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _pressed ? 3 : 0, 0),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: fill,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: lip,
              offset: Offset(0, _pressed ? 2 : 5),
              blurRadius: 0,
            ),
            BoxShadow(
              color: fill.withValues(alpha: 0.45),
              offset: const Offset(0, 12),
              blurRadius: 26,
            ),
          ],
        ),
        child: Text(
          widget.buttonText ?? '',
          textAlign: TextAlign.center,
          maxLines: 1,
          softWrap: false,
          style: NeonText.display(
            size: widget.fontSize,
            color: widget.textColor ?? AppColors.inkOnFill,
          ),
        ),
      ),
    );
  }
}
