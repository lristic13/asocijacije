import 'package:asocijacije_nove/constants/app_colors.dart';
import 'package:asocijacije_nove/constants/app_routes.dart';
import 'package:asocijacije_nove/constants/app_styles.dart';
import 'package:asocijacije_nove/l10n/app_localizations.dart';
import 'package:asocijacije_nove/models/game_mode.dart';
import 'package:asocijacije_nove/providers/all_providers.dart';
import 'package:asocijacije_nove/services/words_loader.dart';
import 'package:asocijacije_nove/widgets/app_page_header.dart';
import 'package:asocijacije_nove/widgets/app_separator.dart';
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
      backgroundColor: AppColors.englishVioletDarker,
      body: Container(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppPageHeader(
              title: localizations.izaberiReci,
            ),
            const AppSeparator(color: AppColors.coral),
            const SizedBox(height: 30),

            Text(
              localizations.kakoZeliteDaIgrate,
              style: AppStyles.text20WhiteBold,
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

            // Option 2: Custom Words
            _WordSourceOption(
              icon: Icons.qr_code,
              title: localizations.koristiSvojeReci,
              subtitle: localizations.svakiIgracDodaje,
              onTap: () => _startWithCustomWords(context, ref),
            ),

            const Spacer(),

            // Back button
            Padding(
              padding: const EdgeInsets.only(bottom: 35.0),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.white, width: 2),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    localizations.nazad,
                    style: AppStyles.text20WhiteBold,
                  ),
                ),
              ),
            ),
          ],
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
    final words = await Navigator.pushNamed(
      context,
      AppRoutes.wordCollectionPage,
    );

    if (words != null && words is List<String> && context.mounted) {
      ref.read(customWordsListProvider.notifier).update((state) => words);
      ref.read(customWordsProvider.notifier).update((state) => true);

      words.shuffle();
      ref.read(wordsProvider.notifier).wordsToPlay = words.sublist(
        0,
        ref.read(playerNumberProvider) * GameMode.wordsPerPlayer,
      );

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

  const _WordSourceOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.englishVioletLighter.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.englishVioletMoreLighter,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.coral.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: AppColors.coral,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppStyles.text20WhiteBold,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppStyles.text15WhiteNormal.copyWith(
                      color: AppColors.englishVioletMoreLighter,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.englishVioletMoreLighter,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
