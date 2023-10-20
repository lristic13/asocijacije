import 'package:asoscijacije_nove/constants/app_colors.dart';
import 'package:asoscijacije_nove/constants/app_strings.dart';
import 'package:asoscijacije_nove/constants/app_styles.dart';
import 'package:asoscijacije_nove/mixins/forms_mixin.dart';
import 'package:asoscijacije_nove/widgets/app_player_number_container.dart';
import 'package:asoscijacije_nove/widgets/buttons/base-buttons/app_button_empty.dart';
import 'package:asoscijacije_nove/widgets/buttons/base-buttons/app_button_full.dart';
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
        decoration: AppStyles.containerGradientViolet,
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.pocniIgru,
                      style: AppStyles.text30WhiteBold,
                    ),
                    Text(
                      '.',
                      style: AppStyles.text30CoralBold,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.09,
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
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 60,
                        child: AppButtonEmpty(
                          buttonText: AppStrings.nazad,
                          borderColor: AppColors.white,
                          textColor: AppColors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        height: 60,
                        child: AppButtonFull(
                          buttonText: AppStrings.dalje,
                          fillColor: AppColors.coral,
                          textColor: AppColors.englishVioletDarker,
                          onPressed: () {
                            validateForms(context, ref, formKeys, box, teamId);
                          },
                        ),
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

  bool _isSelected(int index) {
    return ref.read(playerNumberProvider.notifier).state == (index + 2) * 2;
  }
}
