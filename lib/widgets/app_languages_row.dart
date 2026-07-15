import 'package:asocijacije_nove/constants/app_colors.dart';
import 'package:asocijacije_nove/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/all_providers.dart' show localeProvider;

/// Segmented language control — a rounded pill with two options (Srpski /
/// English). The active option gets an orange fill with dark text.
class AppLanguagesRow extends ConsumerWidget {
  const AppLanguagesRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _segment(ref, 'Srpski', const Locale('sr')),
          const SizedBox(width: 6),
          _segment(ref, 'English', const Locale('en')),
        ],
      ),
    );
  }

  Widget _segment(WidgetRef ref, String text, Locale locale) {
    final active = ref.watch(localeProvider) == locale;
    return GestureDetector(
      onTap: () => ref.read(localeProvider.notifier).update((state) => locale),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: active ? AppColors.orange : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          text,
          style: NeonText.body(
            size: 13,
            weight: FontWeight.w700,
            color: active ? AppColors.inkOnFill : AppColors.sub,
          ),
        ),
      ),
    );
  }
}
