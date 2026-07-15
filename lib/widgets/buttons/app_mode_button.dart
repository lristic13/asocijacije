import 'package:asocijacije_nove/constants/app_colors.dart';
import 'package:asocijacije_nove/constants/app_styles.dart';
import 'package:asocijacije_nove/models/game_mode.dart';
import 'package:asocijacije_nove/providers/all_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Mode toggle cell — active gets a cyan fill, dark text and a cyan glow.
class AppModeButton extends ConsumerStatefulWidget {
  const AppModeButton({
    super.key,
    required this.modeName,
    required this.mode,
    required this.onSelected,
  });

  final void Function()? onSelected;
  final String modeName;
  final GameMode mode;

  @override
  ConsumerState<AppModeButton> createState() => _AppModeButtonState();
}

class _AppModeButtonState extends ConsumerState<AppModeButton> {
  @override
  Widget build(BuildContext context) {
    final isSelected = ref.watch(gameModeProvider) == widget.mode;
    return Expanded(
      child: GestureDetector(
        onTap: widget.onSelected,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.cyan
                : Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(14),
            border: isSelected
                ? null
                : Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                    width: 1.5,
                  ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.cyan.withValues(alpha: 0.4),
                      blurRadius: 18,
                    ),
                  ]
                : null,
          ),
          child: Text(
            widget.modeName,
            style: NeonText.display(
              size: 16,
              color: isSelected ? AppColors.inkOnFill : AppColors.sub,
            ),
          ),
        ),
      ),
    );
  }
}
