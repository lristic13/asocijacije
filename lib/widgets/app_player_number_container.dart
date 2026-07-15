import 'package:asocijacije_nove/constants/app_colors.dart';
import 'package:asocijacije_nove/constants/app_styles.dart';
import 'package:asocijacije_nove/l10n/app_localizations.dart';
import 'package:asocijacije_nove/mixins/forms_mixin.dart';
import 'package:asocijacije_nove/providers/all_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Player-count chip — a number over the "players" label. Active = orange fill
/// with a glow and dark text; inactive = faint fill with a hairline border.
class AppPlayerNumberContainer extends StatelessWidget with FormsMixin {
  const AppPlayerNumberContainer({
    required this.value,
    required this.ref,
    required this.cbOnTap,
    super.key,
  });

  final Function()? cbOnTap;
  final int value;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final active = value == ref.watch(playerNumberProvider);
    return GestureDetector(
      onTap: cbOnTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(vertical: 11),
        decoration: BoxDecoration(
          color: active ? AppColors.orange : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: active
              ? null
              : Border.all(color: Colors.white.withValues(alpha: 0.1), width: 1.5),
          boxShadow: active
              ? [
                  BoxShadow(
                    color: AppColors.orange.withValues(alpha: 0.5),
                    blurRadius: 22,
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value.toString(),
              style: NeonText.display(
                size: 22,
                height: 1,
                color: active ? AppColors.inkOnFill : AppColors.ink,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              AppLocalizations.of(context)!.igraca,
              style: NeonText.body(
                size: 10,
                weight: FontWeight.w700,
                color: active ? AppColors.inkOnFill : AppColors.sub,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
