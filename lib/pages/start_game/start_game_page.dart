import 'package:asoscijacije_nove/constants/app_colors.dart';
import 'package:asoscijacije_nove/constants/app_styles.dart';
import 'package:asoscijacije_nove/mixins/forms_mixin.dart';
import 'package:asoscijacije_nove/widgets/app_page_header.dart';
import 'package:asoscijacije_nove/widgets/app_player_number_container.dart';
import 'package:asoscijacije_nove/widgets/app_round_row.dart';
import 'package:asoscijacije_nove/widgets/app_separator.dart';
import 'package:asoscijacije_nove/widgets/buttons/app_button_row.dart';
import 'package:asoscijacije_nove/widgets/buttons/app_mode_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  List<GlobalKey<FormBuilderState>> formKeys =
      List.generate(2, (i) => GlobalKey<FormBuilderState>());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Hive.openBox<Team>('teams');
      box = Hive.box<Team>('teams')..clear();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context)!;
    String selectedGameMode = ref.watch(gameModeProvider);
    
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: Container(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        color: AppColors.englishVioletDarker,
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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
                        ref.read(playerNumberProvider.notifier).state = 4;
                        formKeys = generateKeys(ref);
                      },
                    ),
                    AppPlayerNumberContainer(
                      value: 6,
                      ref: ref,
                      cbOnTap: () {
                        ref.read(playerNumberProvider.notifier).state = 6;
                        formKeys = generateKeys(ref);
                      },
                    ),
                    AppPlayerNumberContainer(
                      value: 8,
                      ref: ref,
                      cbOnTap: () {
                        ref.read(playerNumberProvider.notifier).state = 8;
                        formKeys = generateKeys(ref);
                      },
                    ),
                    AppPlayerNumberContainer(
                      value: 10,
                      ref: ref,
                      cbOnTap: () {
                        ref.read(playerNumberProvider.notifier).state = 10;
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
                  Text(localizations.izaberiMod,
                      style: AppStyles.text20WhiteBold),
                  const Text('.', style: AppStyles.text20CoralBold),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  AppModeButton(
                    modeName: localizations.normalan,
                    onSelected: () {
                      ref.read(gameModeProvider.notifier).state =
                          localizations.normalan;
                    },
                  ),
                  const SizedBox(width: 10),
                  AppModeButton(
                    modeName: localizations.brzi,
                    onSelected: () {
                      ref.read(gameModeProvider.notifier).state =
                          localizations.brzi;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 5),
              AppRoundRow(
                roundName: localizations.normalnaRunda,
                roundLength:
                    selectedGameMode == localizations.normalan ? 45 : 30,
              ),
              AppRoundRow(
                roundName: localizations.jednaRecRunda,
                roundLength:
                    selectedGameMode == localizations.normalan ? 45 : 30,
              ),
              AppRoundRow(
                roundName: localizations.pantomimaRunda,
                roundLength:
                    selectedGameMode == localizations.normalan ? 60 : 45,
              ),
              const Divider(),
              Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: ref.watch(playerNumberProvider) ~/ 2,
                    itemBuilder: (context, index) =>
                        TeamCard(formKeys[index], index, 5),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              AppButtonRow(
                leftButtonText: AppLocalizations.of(context)!.nazad,
                rightButtonText: AppLocalizations.of(context)!.dalje,
                leftButtonCb: () {
                  Navigator.pop(context);
                },
                rightButtonCb: () {
                  validateForms(context, ref, formKeys, box, teamId);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
