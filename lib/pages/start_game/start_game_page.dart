import 'package:asocijacije_nove/constants/app_colors.dart';
import 'package:asocijacije_nove/constants/app_styles.dart';
import 'package:asocijacije_nove/l10n/app_localizations.dart';
import 'package:asocijacije_nove/mixins/forms_mixin.dart';
import 'package:asocijacije_nove/models/game_mode.dart';
import 'package:asocijacije_nove/widgets/app_page_header.dart';
import 'package:asocijacije_nove/widgets/app_player_number_container.dart';
import 'package:asocijacije_nove/widgets/app_round_row.dart';
import 'package:asocijacije_nove/widgets/app_separator.dart';
import 'package:asocijacije_nove/widgets/buttons/app_button_row.dart';
import 'package:asocijacije_nove/widgets/buttons/app_mode_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../models/team.dart';
import '../../providers/all_providers.dart';
import '../../widgets/cards/team_card.dart';

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
      backgroundColor: AppColors.englishVioletDarker,
      body: Container(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        color: AppColors.englishVioletDarker,
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
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppPlayerNumberContainer(
                              value: 4,
                              ref: ref,
                              cbOnTap: () {
                                ref
                                    .read(playerNumberProvider.notifier)
                                    .update((state) => 4);
                                formKeys = generateKeys(ref);
                              },
                            ),
                            AppPlayerNumberContainer(
                              value: 6,
                              ref: ref,
                              cbOnTap: () {
                                ref
                                    .read(playerNumberProvider.notifier)
                                    .update((state) => 6);
                                formKeys = generateKeys(ref);
                              },
                            ),
                            AppPlayerNumberContainer(
                              value: 8,
                              ref: ref,
                              cbOnTap: () {
                                ref
                                    .read(playerNumberProvider.notifier)
                                    .update((state) => 8);
                                formKeys = generateKeys(ref);
                              },
                            ),
                            AppPlayerNumberContainer(
                              value: 10,
                              ref: ref,
                              cbOnTap: () {
                                ref
                                    .read(playerNumberProvider.notifier)
                                    .update((state) => 10);
                                formKeys = generateKeys(ref);
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(),
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
                      Row(
                        children: [
                          Text(
                            localizations.dupliPoeni,
                            style: AppStyles.text20WhiteBold,
                          ),
                          const SizedBox(width: 5),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: AppColors.englishVioletDarker,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                builder: (context) => Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            localizations.dupliPoeni,
                                            style: AppStyles.text25WhiteBold,
                                          ),
                                          const Text(
                                            '.',
                                            style: AppStyles.text25CoralBold,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      RichText(
                                        text: TextSpan(
                                          style: AppStyles.text15WhiteNormal
                                              .copyWith(
                                                fontFamily: 'Geologica',
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
                                color: AppColors.englishVioletDarker,
                                border: Border.all(
                                  color: Colors.grey.shade400,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(
                                  Icons.question_mark,
                                  color: Colors.grey.shade400,
                                  size: 15,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Switch.adaptive(
                            value: ref.watch(doublePointsProvider),
                            thumbColor: WidgetStateProperty.resolveWith<Color>(
                              (states) => states.contains(WidgetState.selected)
                                  ? AppColors.englishVioletDarker
                                  : AppColors.englishVioletMoreLighter,
                            ),
                            trackColor: WidgetStateProperty.resolveWith<Color>(
                              (states) => states.contains(WidgetState.selected)
                                  ? AppColors.englishVioletMoreLighter
                                  : AppColors.englishVioletDarker,
                            ),
                            trackOutlineColor: WidgetStateProperty.all<Color>(
                              AppColors.englishVioletMoreLighter,
                            ),
                            onChanged: (value) {
                              ref
                                  .read(doublePointsProvider.notifier)
                                  .update((state) => value);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      AppRoundRow(
                        roundName: localizations.normalnaRunda,
                        roundLength: selectedGameMode == GameMode.normal
                            ? GameMode.normalRound1And2Duration
                            : GameMode.quickRound1And2Duration,
                      ),
                      AppRoundRow(
                        roundName: localizations.jednaRecRunda,
                        roundLength: selectedGameMode == GameMode.normal
                            ? GameMode.normalRound1And2Duration
                            : GameMode.quickRound1And2Duration,
                      ),
                      AppRoundRow(
                        roundName: localizations.pantomimaRunda,
                        roundLength: selectedGameMode == GameMode.normal
                            ? GameMode.normalRound3Duration
                            : GameMode.quickRound3Duration,
                      ),
                      const Divider(),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: ref.watch(playerNumberProvider) ~/ 2,
                        itemBuilder: (context, index) =>
                            TeamCard(formKeys[index], index, 5),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: AppButtonRow(
                  leftButtonText: AppLocalizations.of(context)!.nazad,
                  rightButtonText: AppLocalizations.of(context)!.dalje,
                  leftButtonCb: () {
                    Navigator.pop(context);
                  },
                  rightButtonCb: () {
                    validateForms(context, ref, formKeys, box, teamId);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
