import 'package:asoscijacije_nove/constants/app_colors.dart';
import 'package:asoscijacije_nove/mixins/forms_mixin.dart';
import 'package:asoscijacije_nove/widgets/app_page_header.dart';
import 'package:asoscijacije_nove/widgets/app_player_number_container.dart';
import 'package:asoscijacije_nove/widgets/buttons/app_button_row.dart';
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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: Container(
        color: AppColors.englishVioletDarker,
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppPageHeader(title: AppLocalizations.of(context)!.pocniIgru),
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
                Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
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
      ),
    );
  }
}
