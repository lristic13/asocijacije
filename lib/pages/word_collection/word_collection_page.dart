import 'package:asocijacije_nove/constants/app_colors.dart';
import 'package:asocijacije_nove/constants/app_styles.dart';
import 'package:asocijacije_nove/l10n/app_localizations.dart';
import 'package:asocijacije_nove/models/session_state.dart';
import 'package:asocijacije_nove/providers/all_providers.dart';
import 'package:asocijacije_nove/services/word_collection_service.dart';
import 'package:asocijacije_nove/widgets/app_page_header.dart';
import 'package:asocijacije_nove/widgets/app_separator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

class WordCollectionPage extends ConsumerStatefulWidget {
  const WordCollectionPage({super.key});

  @override
  ConsumerState<WordCollectionPage> createState() => _WordCollectionPageState();
}

class _WordCollectionPageState extends ConsumerState<WordCollectionPage> {
  final WordCollectionService _service = WordCollectionService();
  String? _sessionId;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _createSession();
  }

  Future<void> _createSession() async {
    try {
      final playerCount = ref.read(playerNumberProvider);
      final hostId = 'host_${DateTime.now().millisecondsSinceEpoch}';
      final sessionId = await _service.createSession(playerCount, hostId);
      setState(() {
        _sessionId = sessionId;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
    }
  }

  String _getWebUrl() {
    final locale = ref.read(localeProvider).languageCode;
    // Replace with your actual Firebase Hosting URL
    return 'https://asocijacije-2ab22.web.app/submit/$_sessionId?lang=$locale';
  }

  Future<void> _startGame(SessionState state) async {
    try {
      final words = await _service.collectWords(_sessionId!);
      await _service.closeSession(_sessionId!);

      if (mounted) {
        Navigator.pop(context, words);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _cancelSession() async {
    if (_sessionId != null) {
      await _service.deleteSession(_sessionId!);
    }
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    // Note: Session cleanup is handled by _cancelSession or _startGame
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.englishVioletDarker,
        body: Center(
          child: CircularProgressIndicator(color: AppColors.coral),
        ),
      );
    }

    if (_error != null) {
      return Scaffold(
        backgroundColor: AppColors.englishVioletDarker,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                localizations.greskaKreiranjaSesije,
                style: AppStyles.text20WhiteBold,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text(localizations.nazad),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.englishVioletDarker,
      body: Container(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppPageHeader(
                      title: localizations.prikupiReci,
                    ),
                    const AppSeparator(color: AppColors.coral),
                    const SizedBox(height: 20),

                    // QR Code Card
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            QrImageView(
                              data: _getWebUrl(),
                              version: QrVersions.auto,
                              size: 200.0,
                              backgroundColor: Colors.white,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              localizations.skenirajDaDodas,
                              style: AppStyles.text15WhiteNormal.copyWith(
                                color: AppColors.englishVioletDarker,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Progress Section
                    StreamBuilder<SessionState>(
                      stream: _service.watchSession(_sessionId!),
                      builder: (context, snapshot) {
                        final state = snapshot.data ?? SessionState.empty(_sessionId!);
                        final progress = state.targetWords > 0
                            ? state.totalWords / state.targetWords
                            : 0.0;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Progress Header
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  localizations.napredak,
                                  style: AppStyles.text20WhiteBold,
                                ),
                                Text(
                                  '${state.totalWords} / ${state.targetWords}',
                                  style: state.isReady
                                      ? AppStyles.text20CoralBold.copyWith(
                                          color: Colors.green,
                                        )
                                      : AppStyles.text20CoralBold,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // Progress Bar
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: LinearProgressIndicator(
                                value: progress,
                                minHeight: 12,
                                backgroundColor:
                                    AppColors.englishVioletMoreLighter,
                                color: state.isReady
                                    ? Colors.green
                                    : AppColors.coral,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Players Ready
                            Text(
                              localizations.language == 'Srpski'
                                  ? '${state.playersReady} od ${state.playerCount} igrača spremno'
                                  : '${state.playersReady} of ${state.playerCount} players ready',
                              style: AppStyles.text15WhiteNormal,
                            ),

                            const SizedBox(height: 24),

                            // Player List
                            Text(
                              localizations.igraci,
                              style: AppStyles.text20WhiteBold,
                            ),
                            const SizedBox(height: 12),

                            ...List.generate(state.playerCount, (index) {
                              final submissions = state.submissions.values.toList();
                              final hasSubmission = index < submissions.length;
                              final submission =
                                  hasSubmission ? submissions[index] : null;
                              final wordCount = submission?.words.length ?? 0;
                              final isComplete = wordCount == 8;

                              return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.englishVioletLighter
                                      .withValues(alpha: 0.3),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isComplete
                                        ? Colors.green
                                        : AppColors.englishVioletMoreLighter,
                                    width: 2,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      isComplete
                                          ? Icons.check_circle
                                          : Icons.pending,
                                      color: isComplete
                                          ? Colors.green
                                          : AppColors.englishVioletMoreLighter,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        submission?.playerName ??
                                            '${localizations.igrac} ${index + 1}',
                                        style: isComplete
                                            ? AppStyles.text15WhiteBold
                                            : AppStyles.text15WhiteNormal,
                                      ),
                                    ),
                                    Text(
                                      '$wordCount / 8',
                                      style: isComplete
                                          ? AppStyles.text15WhiteBold.copyWith(
                                              color: Colors.green,
                                            )
                                          : AppStyles.text15CoralBold,
                                    ),
                                  ],
                                ),
                              );
                            }),

                            const SizedBox(height: 16),

                            // Start Game Button
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed:
                                    state.isReady ? () => _startGame(state) : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      state.isReady ? Colors.green : Colors.grey,
                                  disabledBackgroundColor: Colors.grey.shade700,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  state.isReady
                                      ? localizations.pocniIgruBtn
                                      : localizations.cekanjeNaReci,
                                  style: AppStyles.text20WhiteBold,
                                ),
                              ),
                            ),

                            if (!state.isReady) ...[
                              const SizedBox(height: 8),
                              Center(
                                child: Text(
                                  localizations.language == 'Srpski'
                                      ? 'Potrebno još ${state.targetWords - state.totalWords} reči'
                                      : 'Need ${state.targetWords - state.totalWords} more words',
                                  style: AppStyles.text15WhiteNormal.copyWith(
                                    color: AppColors.englishVioletMoreLighter,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 35.0),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _cancelSession,
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
}
