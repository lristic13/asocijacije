import 'package:asocijacije_nove/constants/app_colors.dart';
import 'package:asocijacije_nove/constants/app_styles.dart';
import 'package:asocijacije_nove/l10n/app_localizations.dart';
import 'package:asocijacije_nove/models/session_state.dart';
import 'package:asocijacije_nove/providers/all_providers.dart';
import 'package:asocijacije_nove/services/word_collection_service.dart';
import 'package:asocijacije_nove/widgets/app_page_header.dart';
import 'package:asocijacije_nove/widgets/app_separator.dart';
import 'package:asocijacije_nove/widgets/buttons/base-buttons/app_button_empty.dart';
import 'package:asocijacije_nove/widgets/buttons/base-buttons/app_button_full.dart';
import 'package:asocijacije_nove/widgets/neon_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
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
        body: NeonBackground(
          child: Center(
            child: CircularProgressIndicator(color: AppColors.orange),
          ),
        ),
      );
    }

    if (_error != null) {
      return Scaffold(
        body: NeonBackground(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  localizations.greskaKreiranjaSesije,
                  style: NeonText.display(size: 20, color: AppColors.ink),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
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
      );
    }

    return Scaffold(
      body: NeonBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 8, left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppPageHeader(title: localizations.prikupiReci),
                        const AppSeparator(color: AppColors.orange),
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
                              style: NeonText.body(
                                size: 13,
                                weight: FontWeight.w600,
                                color: AppColors.bg,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // "Add my words" button for the host
                    Center(
                      child: TextButton.icon(
                        onPressed: () async {
                          final url = Uri.parse(_getWebUrl());
                          if (await canLaunchUrl(url)) {
                            await launchUrl(
                              url,
                              mode: LaunchMode.externalApplication,
                            );
                          }
                        },
                        icon: const Icon(
                          Icons.open_in_new,
                          color: AppColors.orange,
                        ),
                        label: Text(
                          localizations.dodajMojeReci,
                          style: NeonText.display(
                            size: 15,
                            color: AppColors.orange,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Progress Section
                    StreamBuilder<SessionState>(
                      stream: _service.watchSession(_sessionId!),
                      builder: (context, snapshot) {
                        final state =
                            snapshot.data ?? SessionState.empty(_sessionId!);
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
                                  localizations.dodatoReci,
                                  style: NeonText.display(
                                    size: 20,
                                    color: AppColors.ink,
                                  ),
                                ),
                                Text(
                                  '${state.totalWords} / ${state.targetWords}',
                                  style: NeonText.display(
                                    size: 20,
                                    color: state.isReady
                                        ? AppColors.cyan
                                        : AppColors.orange,
                                  ),
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
                                    Colors.white.withValues(alpha: 0.08),
                                color: state.isReady
                                    ? AppColors.cyan
                                    : AppColors.orange,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Players Ready
                            Text(
                              localizations.language == 'Srpski'
                                  ? '${state.playersReady} od ${state.playerCount} igrača spremno'
                                  : '${state.playersReady} of ${state.playerCount} players ready',
                              style: NeonText.body(
                                size: 13,
                                weight: FontWeight.w600,
                                color: AppColors.sub,
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Player List
                            Text(
                              localizations.igraci,
                              style: NeonText.display(
                                size: 20,
                                color: AppColors.ink,
                              ),
                            ),
                            const SizedBox(height: 12),

                            ...List.generate(state.playerCount, (index) {
                              final submissions = state.submissions.values
                                  .toList();
                              final hasSubmission = index < submissions.length;
                              final submission = hasSubmission
                                  ? submissions[index]
                                  : null;
                              final wordCount = submission?.words.length ?? 0;
                              final isComplete = wordCount == 8;

                              return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.04),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isComplete
                                        ? AppColors.cyan.withValues(alpha: 0.5)
                                        : Colors.white.withValues(alpha: 0.1),
                                    width: 1.5,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    if (isComplete)
                                      const Icon(
                                        Icons.check_circle,
                                        color: AppColors.cyan,
                                      )
                                    else
                                      Lottie.asset(
                                        'assets/animations/loading_dots.json',
                                        width: 24,
                                        height: 24,
                                      ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        submission?.playerName ??
                                            '${localizations.igrac} ${index + 1}',
                                        style: NeonText.body(
                                          size: 15,
                                          weight: isComplete
                                              ? FontWeight.w700
                                              : FontWeight.w600,
                                          color: AppColors.ink,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '$wordCount / 8',
                                      style: NeonText.display(
                                        size: 15,
                                        color: isComplete
                                            ? AppColors.cyan
                                            : AppColors.orange,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),

                            const SizedBox(height: 16),

                            // Start Game Button
                            if (state.isReady)
                              AppButtonFull(
                                buttonText: localizations.pocniIgruBtn,
                                fillColor: AppColors.cyan,
                                textColor: AppColors.inkOnFill,
                                onPressed: () => _startGame(state),
                              )
                            else
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.04),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.1),
                                    width: 1.5,
                                  ),
                                ),
                                child: Text(
                                  localizations.cekanjeNaReci,
                                  textAlign: TextAlign.center,
                                  style: NeonText.display(
                                    size: 20,
                                    color: AppColors.sub,
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
                                  style: NeonText.body(
                                    size: 13,
                                    weight: FontWeight.w600,
                                    color: AppColors.sub,
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
              child: AppButtonEmpty(
                buttonText: localizations.nazad,
                borderColor: AppColors.ink,
                textColor: AppColors.ink,
                onPressed: _cancelSession,
              ),
            ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
