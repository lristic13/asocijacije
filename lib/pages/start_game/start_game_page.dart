import 'package:asoscijacije_nove/constants/app_colors.dart';
import 'package:asoscijacije_nove/constants/app_routes.dart';
import 'package:asoscijacije_nove/constants/app_strings.dart';
import 'package:asoscijacije_nove/constants/app_styles.dart';
import 'package:asoscijacije_nove/mixins/forms_mixin.dart';
import 'package:asoscijacije_nove/widgets/buttons/app_button_empty.dart';
import 'package:asoscijacije_nove/widgets/buttons/app_button_full.dart';
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
  late List<GlobalKey<FormBuilderState>> formKeys = List.generate(
      ref.read(playerNumberProvider) ~/ 2,
      (i) => GlobalKey<FormBuilderState>());
  late Box box;
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: AppStyles.containerGradientViolet,
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    AppStrings.brojIgraca,
                    style: AppStyles.text25WhiteBold,
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      AppStrings.izaberiteBrojIgraca,
                      style: AppStyles.text20WhiteDarkerNormal,
                    ),
                  ),
                  FormBuilderChoiceChip(
                    backgroundColor: AppColors.white,
                    onChanged: (value) {
                      ref.read(playerNumberProvider.notifier).state = value!;
                      print('players: ${ref.read(playerNumberProvider)}');
                      setState(() {
                        formKeys = List.generate(
                            ref.watch(playerNumberProvider) ~/ 2,
                            (i) => GlobalKey<FormBuilderState>());
                      });
                    },
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    initialValue: 4,
                    name: 'players',
                    options: const [
                      FormBuilderChipOption(
                          value: 4,
                          child: Text('4',
                              style: AppStyles.text20VioletDarkerBold)),
                      FormBuilderChipOption(
                          value: 6,
                          child: Text('6',
                              style: AppStyles.text20VioletDarkerBold)),
                      FormBuilderChipOption(
                          value: 8,
                          child: Text('8',
                              style: AppStyles.text20VioletDarkerBold)),
                    ],
                  ),
                  Expanded(
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
                            borderColor: AppColors.coral,
                            textColor: AppColors.coral,
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  AppRoutes.homePage, (route) => false);
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
                              validateForms(
                                  context, ref, formKeys, box, teamId);
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
      ),
    );
  }
}
