import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';

/// Primary "lip + glow" button — a bright accent fill with a hard un-blurred
/// bottom lip (3D tactile key) and a soft colored glow. Depresses on press.
class NaButton extends StatefulWidget {
  const NaButton({
    required this.label,
    required this.onPressed,
    this.color = AppColors.orange,
    this.lip = AppColors.orangeLip,
    this.glow = AppColors.orange,
    this.fontSize = 19,
    this.leading,
    super.key,
  });

  /// Convenience: cyan "confirm" variant.
  const NaButton.confirm({
    required String label,
    required VoidCallback onPressed,
    double fontSize = 19,
    Widget? leading,
    Key? key,
  }) : this(
          label: label,
          onPressed: onPressed,
          color: AppColors.cyan,
          lip: AppColors.cyanLip,
          glow: AppColors.cyan,
          fontSize: fontSize,
          leading: leading,
          key: key,
        );

  final String label;
  final VoidCallback onPressed;
  final Color color;
  final Color lip;
  final Color glow;
  final double fontSize;
  final Widget? leading;

  @override
  State<NaButton> createState() => _NaButtonState();
}

class _NaButtonState extends State<NaButton> {
  bool _pressed = false;

  void _setPressed(bool v) {
    if (_pressed != v) setState(() => _pressed = v);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _pressed ? 3 : 0, 0),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: widget.lip,
              offset: Offset(0, _pressed ? 2 : 5),
              blurRadius: 0,
            ),
            BoxShadow(
              color: widget.glow.withValues(alpha: 0.45),
              offset: const Offset(0, 12),
              blurRadius: 26,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.leading != null) ...[
              widget.leading!,
              const SizedBox(width: 9),
            ],
            Text(
              widget.label,
              maxLines: 1,
              overflow: TextOverflow.visible,
              softWrap: false,
              style: NeonText.display(
                size: widget.fontSize,
                color: AppColors.inkOnFill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Ghost button — outlined accent-colored label on a faint fill. Brightens on
/// press. Used in pairs (e.g. Give up / Got it, Instructions / Exit).
class NaGhostButton extends StatefulWidget {
  const NaGhostButton({
    required this.label,
    required this.onPressed,
    this.color = AppColors.ink,
    this.leading,
    this.fontSize = 16,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final Color color;
  final Widget? leading;
  final double fontSize;

  @override
  State<NaGhostButton> createState() => _NaGhostButtonState();
}

class _NaGhostButtonState extends State<NaGhostButton> {
  bool _pressed = false;

  void _setPressed(bool v) {
    if (_pressed != v) setState(() => _pressed = v);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: _pressed ? 0.08 : 0.04),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: widget.color.withValues(alpha: 0.33),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.leading != null) ...[
              widget.leading!,
              const SizedBox(width: 9),
            ],
            Text(
              widget.label,
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.visible,
              style: NeonText.display(size: widget.fontSize, color: widget.color),
            ),
          ],
        ),
      ),
    );
  }
}
