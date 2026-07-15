import 'package:asocijacije_nove/constants/app_colors.dart';
import 'package:asocijacije_nove/constants/app_routes.dart';
import 'package:asocijacije_nove/constants/feature_flags.dart';
import 'package:asocijacije_nove/constants/app_styles.dart';
import 'package:asocijacije_nove/l10n/app_localizations.dart';
import 'package:asocijacije_nove/models/game_mode.dart';
import 'package:asocijacije_nove/providers/all_providers.dart';
import 'package:asocijacije_nove/services/words_loader.dart';
import 'package:asocijacije_nove/widgets/app_page_header.dart';
import 'package:asocijacije_nove/widgets/app_separator.dart';
import 'package:asocijacije_nove/widgets/buttons/base-buttons/app_button_empty.dart';
import 'package:asocijacije_nove/widgets/neon_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';

import '../game/game_page.dart';

class WordSourcePage extends ConsumerWidget {
  const WordSourcePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: NeonBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 8, left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppPageHeader(
                  title: localizations.izaberiReci,
                ),
                const AppSeparator(color: AppColors.orange),
            const SizedBox(height: 30),

            Text(
              localizations.kakoZeliteDaIgrate,
              style: NeonText.display(size: 20, color: AppColors.ink),
            ),
            const SizedBox(height: 20),

            // Option 1: App's Words
            _WordSourceOption(
              icon: Icons.auto_awesome,
              title: localizations.koristiReciIzAplikacije,
              subtitle: localizations.viseOdReciSpremno,
              onTap: () => _startWithAppWords(context, ref),
            ),

            const SizedBox(height: 16),

            // Option 2: Custom Words (pro unlock)
            _WordSourceOption(
              icon: Icons.qr_code,
              title: localizations.koristiSvojeReci,
              subtitle: localizations.svakiIgracDodaje,
              locked: FeatureFlags.paywallEnabled && !ref.watch(proProvider),
              onTap: () => _startWithCustomWords(context, ref),
            ),

            const Spacer(),

            // Back button
            Padding(
              padding: const EdgeInsets.only(bottom: 35.0),
              child: AppButtonEmpty(
                buttonText: localizations.nazad,
                borderColor: AppColors.ink,
                textColor: AppColors.ink,
                onPressed: () => Navigator.pop(context),
              ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _startWithAppWords(BuildContext context, WidgetRef ref) async {
    final localeCode =
        ref.read(localeProvider) == const Locale('sr') ? 'sr' : 'en';
    final words = await WordsLoader.loadWords(localeCode);
    words.shuffle();

    if (!context.mounted) return;

    ref.read(wordsProvider.notifier).wordsToPlay =
        words.sublist(0, ref.read(playerNumberProvider) * GameMode.wordsPerPlayer);

    Navigator.push(
      context,
      PageTransition(
        child: const GamePage(),
        type: PageTransitionType.leftToRight,
      ),
    );
  }

  Future<void> _startWithCustomWords(BuildContext context, WidgetRef ref) async {
    if (FeatureFlags.paywallEnabled && !ref.read(proProvider)) {
      final unlocked = await Navigator.pushNamed(
        context,
        AppRoutes.paywallPage,
      );
      if (unlocked != true || !context.mounted) return;
    }

    final result = await Navigator.pushNamed(
      context,
      AppRoutes.wordCollectionPage,
    );

    if (result != null && result is List<String> && result.isNotEmpty && context.mounted) {
      final words = List<String>.from(result);
      ref.read(customWordsListProvider.notifier).update((state) => words);
      ref.read(customWordsProvider.notifier).update((state) => true);

      words.shuffle();

      // Use all available words (don't try to get more than we have)
      final wordsNeeded = ref.read(playerNumberProvider) * GameMode.wordsPerPlayer;
      final wordsToUse = words.length >= wordsNeeded
          ? words.sublist(0, wordsNeeded)
          : words;

      ref.read(wordsProvider.notifier).wordsToPlay = wordsToUse;

      Navigator.push(
        context,
        PageTransition(
          child: const GamePage(),
          type: PageTransitionType.leftToRight,
        ),
      );
    }
  }
}

class _WordSourceOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool locked;

  const _WordSourceOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.locked = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: AppColors.violet.withValues(alpha: 0.33),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.violet.withValues(alpha: 0.13),
              blurRadius: 18,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.orange.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: AppColors.orange,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          style:
                              NeonText.display(size: 17, color: AppColors.ink),
                        ),
                      ),
                      if (locked) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.orange.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.orange),
                          ),
                          child: Text(
                            'PRO',
                            style: NeonText.body(
                              size: 10,
                              weight: FontWeight.w800,
                              color: AppColors.orange,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: NeonText.body(
                      size: 13,
                      weight: FontWeight.w600,
                      color: AppColors.sub,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.sub,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
