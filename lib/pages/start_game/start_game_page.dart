import 'package:asocijacije_nove/constants/app_colors.dart';
import 'package:asocijacije_nove/constants/app_styles.dart';
import 'package:asocijacije_nove/l10n/app_localizations.dart';
import 'package:asocijacije_nove/mixins/forms_mixin.dart';
import 'package:asocijacije_nove/models/game_mode.dart';
import 'package:asocijacije_nove/models/one_vs_one_state.dart';
import 'package:asocijacije_nove/services/words_loader.dart';
import 'package:asocijacije_nove/widgets/app_page_header.dart';
import 'package:asocijacije_nove/widgets/app_player_number_container.dart';
import 'package:asocijacije_nove/widgets/app_round_row.dart';
import 'package:asocijacije_nove/widgets/app_separator.dart';
import 'package:asocijacije_nove/widgets/buttons/app_mode_button.dart';
import 'package:asocijacije_nove/widgets/neon_background.dart';
import 'package:asocijacije_nove/widgets/buttons/neon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';

import '../../models/team.dart';
import '../../providers/all_providers.dart';
import '../../widgets/cards/team_card.dart';
import '../game/game_page.dart';

class StartGamePage extends ConsumerStatefulWidget {
  const StartGamePage({super.key});

  @override
  ConsumerState<StartGamePage> createState() => _StartGamePageState();
}

class _StartGamePageState extends ConsumerState<StartGamePage> with FormsMixin {
  int teamId = 1;

  late Box box;
  List<GlobalKey<FormBuilderState>> formKeys = List.generate(
    2,
    (i) => GlobalKey<FormBuilderState>(),
  );

  // 1v1 mode form key
  final _oneVsOneFormKey = GlobalKey<FormBuilderState>();

  bool get _is1v1Mode => ref.watch(playerNumberProvider) == 2;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Hive.openBox<Team>('teams');
      box = Hive.box<Team>('teams')..clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context)!;
    GameMode selectedGameMode = ref.watch(gameModeProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: NeonBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 6, 22, 18),
            child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppPageHeader(title: localizations.pocniIgru),
                      const AppSeparator(color: AppColors.coral),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: _OneVsOneButton(
                              isSelected: _is1v1Mode,
                              onTap: () {
                                ref
                                    .read(playerNumberProvider.notifier)
                                    .update((state) => 2);
                              },
                            ),
                          ),
                          for (final n in const [4, 6, 8, 10]) ...[
                            const SizedBox(width: 9),
                            Expanded(
                              child: AppPlayerNumberContainer(
                                value: n,
                                ref: ref,
                                cbOnTap: () {
                                  ref
                                      .read(playerNumberProvider.notifier)
                                      .update((state) => n);
                                  formKeys = generateKeys(ref);
                                },
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 10),
                      Divider(
                        color: Colors.white.withValues(alpha: 0.08),
                        height: 26,
                      ),
                      Row(
                        children: [
                          Text(
                            localizations.izaberiMod,
                            style: AppStyles.text20WhiteBold,
                          ),
                          const Text('.', style: AppStyles.text20CoralBold),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          AppModeButton(
                            modeName: localizations.normalan,
                            mode: GameMode.normal,
                            onSelected: () {
                              ref
                                  .read(gameModeProvider.notifier)
                                  .update((state) => GameMode.normal);
                            },
                          ),
                          const SizedBox(width: 10),
                          AppModeButton(
                            modeName: localizations.brzi,
                            mode: GameMode.quick,
                            onSelected: () {
                              ref
                                  .read(gameModeProvider.notifier)
                                  .update((state) => GameMode.quick);
                            },
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.04),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            Text(
                              localizations.dupliPoeni,
                              style: NeonText.display(
                                size: 15.5,
                                color: AppColors.ink,
                              ),
                            ),
                            const SizedBox(width: 5),
                            InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: AppColors.bg,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                builder: (context) => Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppPageHeader(
                                        title: localizations.dupliPoeni,
                                      ),
                                      const AppSeparator(
                                        color: AppColors.orange,
                                      ),
                                      const SizedBox(height: 16),
                                      RichText(
                                        text: TextSpan(
                                          style: NeonText.body(
                                            size: 14,
                                            weight: FontWeight.w500,
                                            color: AppColors.sub,
                                          ),
                                          children: [
                                            TextSpan(
                                              text:
                                                  localizations.language ==
                                                      'Srpski'
                                                  ? 'Reči pogođene u poslednjih nekoliko sekundi runde donose '
                                                  : 'Words guessed in the final seconds of the round earn ',
                                            ),
                                            TextSpan(
                                              text:
                                                  localizations.language ==
                                                      'Srpski'
                                                  ? '2 poena '
                                                  : '2 points ',
                                              style: AppStyles.text15WhiteBold,
                                            ),
                                            TextSpan(
                                              text:
                                                  localizations.language ==
                                                      'Srpski'
                                                  ? 'umesto 1!\n\n'
                                                  : 'instead of 1!\n\n',
                                            ),
                                            TextSpan(
                                              text:
                                                  localizations.language ==
                                                      'Srpski'
                                                  ? 'Normalan mod:\n'
                                                  : 'Normal mode:\n',
                                              style: AppStyles.text15WhiteBold,
                                            ),
                                            TextSpan(
                                              text:
                                                  localizations.language ==
                                                      'Srpski'
                                                  ? '• Normalna i Jedna reč runda: poslednjih '
                                                  : '• Normal and One-word rounds: last ',
                                            ),
                                            const TextSpan(
                                              text: '10 ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  localizations.language ==
                                                      'Srpski'
                                                  ? 'sekundi\n• Pantomima runda: poslednjih '
                                                  : 'seconds\n• Mime round: last ',
                                            ),
                                            const TextSpan(
                                              text: '15 ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  localizations.language ==
                                                      'Srpski'
                                                  ? 'sekundi\n\n'
                                                  : 'seconds\n\n',
                                            ),
                                            TextSpan(
                                              text:
                                                  localizations.language ==
                                                      'Srpski'
                                                  ? 'Brzi mod:\n'
                                                  : 'Quick mode:\n',
                                              style: AppStyles.text15WhiteBold,
                                            ),
                                            TextSpan(
                                              text:
                                                  localizations.language ==
                                                      'Srpski'
                                                  ? '• Normalna i Jedna reč runda: poslednjih '
                                                  : '• Normal and One-word rounds: last ',
                                            ),
                                            const TextSpan(
                                              text: '7 ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  localizations.language ==
                                                      'Srpski'
                                                  ? 'sekundi\n• Pantomima runda: poslednjih '
                                                  : 'seconds\n• Mime round: last ',
                                            ),
                                            const TextSpan(
                                              text: '10 ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  localizations.language ==
                                                      'Srpski'
                                                  ? 'sekundi'
                                                  : 'seconds',
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.bg,
                                border: Border.all(
                                  color: AppColors.sub,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Icon(
                                  Icons.question_mark,
                                  color: AppColors.sub,
                                  size: 15,
                                ),
                              ),
                            ),
                          ),
                            const Spacer(),
                            Switch.adaptive(
                              value: ref.watch(doublePointsProvider),
                              activeThumbColor: AppColors.ink,
                              activeTrackColor: AppColors.orange,
                              inactiveThumbColor: AppColors.sub,
                              inactiveTrackColor: Colors.white.withValues(
                                alpha: 0.08,
                              ),
                              trackOutlineColor:
                                  WidgetStateProperty.resolveWith<Color>(
                                (states) =>
                                    states.contains(WidgetState.selected)
                                        ? AppColors.orange
                                        : Colors.white.withValues(alpha: 0.2),
                              ),
                              onChanged: (value) {
                                ref
                                    .read(doublePointsProvider.notifier)
                                    .update((state) => value);
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 13),
                      Row(
                        children: [
                          Expanded(
                            child: AppRoundRow(
                              roundName: localizations.normalnaRunda,
                              roundLength: selectedGameMode == GameMode.normal
                                  ? GameMode.normalRound1And2Duration
                                  : GameMode.quickRound1And2Duration,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: AppRoundRow(
                              roundName: localizations.jednaRecRunda,
                              roundLength: selectedGameMode == GameMode.normal
                                  ? GameMode.normalRound1And2Duration
                                  : GameMode.quickRound1And2Duration,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: AppRoundRow(
                              roundName: localizations.pantomimaRunda,
                              roundLength: selectedGameMode == GameMode.normal
                                  ? GameMode.normalRound3Duration
                                  : GameMode.quickRound3Duration,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 13),
                      if (_is1v1Mode)
                        _OneVsOneForm(formKey: _oneVsOneFormKey)
                      else
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: ref.watch(playerNumberProvider) ~/ 2,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 13),
                          itemBuilder: (context, index) =>
                              TeamCard(formKeys[index], index, 5),
                        ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 11),
                child: Row(
                  children: [
                    Expanded(
                      flex: 10,
                      child: NaGhostButton(
                        label: AppLocalizations.of(context)!.nazad,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(width: 11),
                    Expanded(
                      flex: 14,
                      child: NaButton(
                        label: AppLocalizations.of(context)!.dalje,
                        onPressed: () {
                          if (_is1v1Mode) {
                            _start1v1Game();
                          } else {
                            validateForms(context, ref, formKeys, box, teamId);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _start1v1Game() async {
    if (_oneVsOneFormKey.currentState?.saveAndValidate() != true) {
      return;
    }

    final formData = _oneVsOneFormKey.currentState!.value;
    final player1Name = formData['player1'] as String;
    final player2Name = formData['player2'] as String;

    // Initialize 1v1 state
    ref.read(oneVsOneProvider.notifier).update(
          (state) => OneVsOneState(
            player1Name: player1Name,
            player2Name: player2Name,
            player1Score: 0,
            player2Score: 0,
            currentPlayer: 1,
          ),
        );

    // Set game admin to 1v1 mode
    ref.read(gameAdminProvider.notifier).update(
          (state) => state.copyWith(
            is1v1Mode: true,
            roundInProgress: 1,
            playerExplaining: 1,
            teamPlaying: 1,
            allWordsGuessed: false,
          ),
        );

    // Reset blur
    ref.read(blurProvider.notifier).update((state) => true);

    // Load words (15 per player = 30 total)
    final localeCode =
        ref.read(localeProvider) == const Locale('sr') ? 'sr' : 'en';
    final words = await WordsLoader.loadWords(localeCode);
    words.shuffle();

    if (!mounted) return;

    const wordsNeeded = OneVsOneState.wordsPerPlayer * 2; // 30 words
    ref.read(wordsProvider).wordsToPlay = words.sublist(0, wordsNeeded);

    Navigator.push(
      context,
      PageTransition(
        child: const GamePage(),
        type: PageTransitionType.leftToRight,
      ),
    );
  }
}

class _OneVsOneButton extends StatelessWidget {
  const _OneVsOneButton({
    required this.isSelected,
    required this.onTap,
  });

  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(vertical: 11),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.orange
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? null
              : Border.all(
                  color: Colors.white.withValues(alpha: 0.1),
                  width: 1.5,
                ),
          boxShadow: isSelected
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
              AppLocalizations.of(context)!.jedanNaJedan,
              style: NeonText.display(
                size: 22,
                height: 1,
                color: isSelected ? AppColors.inkOnFill : AppColors.ink,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              AppLocalizations.of(context)!.igraca,
              style: NeonText.body(
                size: 10,
                weight: FontWeight.w700,
                color: isSelected ? AppColors.inkOnFill : AppColors.sub,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OneVsOneForm extends StatelessWidget {
  const _OneVsOneForm({required this.formKey});

  final GlobalKey<FormBuilderState> formKey;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return FormBuilder(
      key: formKey,
      child: Container(
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
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _oneVsOneField(
              'player1',
              localizations.imeIgraca1,
              localizations.unesiteImeIgraca,
            ),
            const SizedBox(height: 12),
            _oneVsOneField(
              'player2',
              localizations.imeIgraca2,
              localizations.unesiteImeIgraca,
            ),
          ],
        ),
      ),
    );
  }

  Widget _oneVsOneField(String name, String label, String errorText) {
    return FormBuilderTextField(
      name: name,
      style: NeonText.display(size: 18, color: AppColors.ink),
      cursorColor: AppColors.violet,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: Colors.black.withValues(alpha: 0.25),
        hintText: label,
        hintStyle: NeonText.body(
          size: 13,
          weight: FontWeight.w600,
          color: AppColors.sub,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        errorStyle: NeonText.body(size: 10, color: AppColors.magenta),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.violet, width: 1.5),
        ),
      ),
      validator: (value) =>
          (value == null || value.isEmpty) ? errorText : null,
    );
  }
}
