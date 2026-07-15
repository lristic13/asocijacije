import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_styles.dart';

/// Ghost button (legacy API kept) — outlined accent label on a faint fill.
/// Brightens its background on press.
class AppButtonEmpty extends StatefulWidget {
  const AppButtonEmpty({
    required this.borderColor,
    required this.textColor,
    required this.buttonText,
    required this.onPressed,
    this.textSize = 16,
    super.key,
  });

  final Color? borderColor;
  final Color? textColor;
  final void Function()? onPressed;
  final String? buttonText;
  final double textSize;

  @override
  State<AppButtonEmpty> createState() => _AppButtonEmptyState();
}

class _AppButtonEmptyState extends State<AppButtonEmpty> {
  bool _pressed = false;

  void _setPressed(bool v) {
    if (_pressed != v) setState(() => _pressed = v);
  }

  @override
  Widget build(BuildContext context) {
    final accent = widget.borderColor ?? AppColors.ink;
    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: _pressed ? 0.08 : 0.04),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: accent.withValues(alpha: 0.33), width: 1.5),
        ),
        child: Text(
          widget.buttonText ?? '',
          textAlign: TextAlign.center,
          maxLines: 1,
          softWrap: false,
          style: NeonText.display(
            size: widget.textSize,
            color: widget.textColor ?? accent,
          ),
        ),
      ),
    );
  }
}
