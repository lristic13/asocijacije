import 'package:asocijacije_nove/constants/app_colors.dart';
import 'package:asocijacije_nove/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/all_providers.dart' show localeProvider;

class _LanguageOption {
  final Locale locale;
  final String flag;
  final String name;

  const _LanguageOption(this.locale, this.flag, this.name);
}

const _languages = [
  _LanguageOption(Locale('sr'), '🇷🇸', 'Srpski'),
  _LanguageOption(Locale('hr'), '🇭🇷', 'Hrvatski'),
  _LanguageOption(Locale('en'), '🇬🇧', 'English'),
];

/// Circular flag button showing the active language. Tapping it opens a
/// bottom sheet with all supported languages and their flags.
class AppLanguagePicker extends ConsumerWidget {
  const AppLanguagePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(localeProvider);
    final active = _languages.firstWhere(
      (l) => l.locale == current,
      orElse: () => _languages.first,
    );

    return GestureDetector(
      onTap: () => _showPicker(context, ref),
      child: Container(
        width: 46,
        height: 46,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.05),
          border: Border.all(
            color: AppColors.violet.withValues(alpha: 0.33),
            width: 1.5,
          ),
        ),
        child: Text(active.flag, style: const TextStyle(fontSize: 22)),
      ),
    );
  }

  void _showPicker(BuildContext context, WidgetRef ref) {
    final current = ref.read(localeProvider);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => Container(
        decoration: const BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.sub.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            for (final lang in _languages)
              _LanguageTile(
                option: lang,
                active: lang.locale == current,
                onTap: () {
                  ref
                      .read(localeProvider.notifier)
                      .update((state) => lang.locale);
                  Navigator.pop(sheetContext);
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  final _LanguageOption option;
  final bool active;
  final VoidCallback onTap;

  const _LanguageTile({
    required this.option,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: active
              ? AppColors.orange.withValues(alpha: 0.15)
              : Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: active
                ? AppColors.orange
                : AppColors.violet.withValues(alpha: 0.33),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Text(option.flag, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                option.name,
                style: NeonText.display(size: 17, color: AppColors.ink),
              ),
            ),
            if (active)
              const Icon(Icons.check_circle, color: AppColors.orange, size: 22),
          ],
        ),
      ),
    );
  }
}
