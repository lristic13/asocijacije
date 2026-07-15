import 'package:asocijacije_nove/constants/app_styles.dart';
import 'package:asocijacije_nove/l10n/app_localizations.dart';
import 'package:asocijacije_nove/models/team.dart';
import 'package:asocijacije_nove/providers/all_providers.dart';
import 'package:asocijacije_nove/services/navigation_service.dart';
import 'package:asocijacije_nove/widgets/app_title_text.dart';
import 'package:asocijacije_nove/widgets/app_languages_row.dart';
import 'package:asocijacije_nove/widgets/buttons/base-buttons/app_button_empty.dart';
import 'package:asocijacije_nove/widgets/buttons/base-buttons/app_button_full.dart';
import 'package:asocijacije_nove/widgets/buttons/neon_button.dart';
import 'package:asocijacije_nove/widgets/neon_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:upgrader/upgrader.dart';

import '../../constants/app_colors.dart';
import '../../widgets/app_subtitle_text.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageConsumerState();
}

class _HomePageConsumerState extends ConsumerState<HomePage> {
  final Upgrader _upgrader = Upgrader(
    // debugDisplayAlways: true, // TODO: Remove before release
    // debugLogging: true,
  );
  bool _hasCheckedForUpdate = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasCheckedForUpdate) {
      _hasCheckedForUpdate = true;
      _checkForUpdate();
    }
  }

  Future<void> _checkForUpdate() async {
    final updateAvailable = await _upgrader.initialize();
    if (!mounted) return;

    if (updateAvailable && _upgrader.shouldDisplayUpgrade()) {
      _showUpdateBottomSheet();
    }
  }

  void _showUpdateBottomSheet() {
    final isSr = Localizations.localeOf(context).languageCode == 'sr';

    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: AppColors.englishVioletDarker,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) =>
          _UpdateBottomSheet(upgrader: _upgrader, isSerbian: isSr),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: NeonBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(26, 8, 26, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(child: AppLanguagesRow()),
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppTitleText(),
                      SizedBox(height: 14),
                      AppSubtitleText(),
                    ],
                  ),
                ),
                NaButton(
                  label: localizations.pocniIgru,
                  fontSize: 22,
                  leading: const Icon(
                    Icons.play_arrow_rounded,
                    color: AppColors.inkOnFill,
                    size: 26,
                  ),
                  onPressed: () {
                    ref
                        .read(playerNumberProvider.notifier)
                        .update((state) => 4);
                    NavigationService.goToStartGame();
                  },
                ),
                const SizedBox(height: 13),
                Row(
                  children: [
                    Expanded(
                      child: NaGhostButton(
                        label: localizations.uputstvaZaIgru,
                        color: AppColors.cyan,
                        onPressed: () => NavigationService.goToInstructions(),
                      ),
                    ),
                    const SizedBox(width: 11),
                    Expanded(
                      child: NaGhostButton(
                        label: localizations.izlaz,
                        color: AppColors.magenta,
                        onPressed: () async {
                          if (Hive.isBoxOpen('teams')) {
                            await Hive.box<Team>('teams').close();
                          }
                          SystemNavigator.pop();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UpdateBottomSheet extends StatelessWidget {
  const _UpdateBottomSheet({required this.upgrader, required this.isSerbian});

  final Upgrader upgrader;
  final bool isSerbian;

  @override
  Widget build(BuildContext context) {
    final currentVersion = upgrader.currentInstalledVersion ?? '';
    final newVersion = upgrader.currentAppStoreVersion ?? '';
    final releaseNotes = upgrader.releaseNotes;

    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.system_update, color: AppColors.orange, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  isSerbian ? 'Nova verzija dostupna' : 'Update available',
                  style: NeonText.display(size: 24, color: AppColors.ink),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            isSerbian
                ? 'Verzija $newVersion je sada dostupna. Vi imate verziju $currentVersion.'
                : 'Version $newVersion is now available. You have version $currentVersion.',
            style: AppStyles.text15WhiteNormal,
          ),
          if (releaseNotes != null && releaseNotes.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              isSerbian ? 'Šta je novo:' : "What's new:",
              style: AppStyles.text15WhiteBold,
            ),
            const SizedBox(height: 8),
            Container(
              constraints: const BoxConstraints(maxHeight: 150),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.englishViolet,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SingleChildScrollView(
                child: Text(releaseNotes, style: AppStyles.text15WhiteNormal),
              ),
            ),
          ],
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: AppButtonEmpty(
                  borderColor: AppColors.white,
                  textColor: AppColors.white,
                  buttonText: isSerbian ? 'Kasnije' : 'Later',
                  onPressed: () {
                    upgrader.saveLastAlerted();
                    Navigator.of(context).pop();
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppButtonFull(
                  fillColor: AppColors.coral,
                  textColor: AppColors.englishVioletDarker,
                  buttonText: isSerbian ? 'Ažuriraj' : 'Update',
                  onPressed: () {
                    upgrader.sendUserToAppStore();
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
