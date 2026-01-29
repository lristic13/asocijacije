import 'package:asocijacije_nove/constants/app_colors.dart';
import 'package:asocijacije_nove/constants/app_styles.dart';
import 'package:asocijacije_nove/models/game_mode.dart';
import 'package:asocijacije_nove/providers/all_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: isSelected
              ? WidgetStateProperty.all<Color>(AppColors.englishVioletLighter)
              : WidgetStateProperty.all<Color>(Colors.transparent),
          padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(5)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              side: const BorderSide(
                color: AppColors.englishVioletLighter,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(13),
            ),
          ),
        ),
        onPressed: widget.onSelected,
        child: Text(
          widget.modeName,
          style: isSelected
              ? AppStyles.text20VioletDarkerBold.copyWith(fontSize: 18)
              : AppStyles.text20WhiteBold.copyWith(fontSize: 18),
        ),
      ),
    );
  }
}
