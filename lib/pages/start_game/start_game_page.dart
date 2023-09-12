import 'package:asoscijacije_nove/constants/app_colors.dart';
import 'package:asoscijacije_nove/constants/app_strings.dart';
import 'package:asoscijacije_nove/constants/app_styles.dart';
import 'package:asoscijacije_nove/mixins/forms_mixin.dart';
import 'package:asoscijacije_nove/widgets/buttons/app_button_empty.dart';
import 'package:asoscijacije_nove/widgets/buttons/app_button_full.dart';
import 'package:asoscijacije_nove/widgets/cards/player_card.dart';
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

class _StartGamePageState extends ConsumerState<StartGamePage>
    with FormsMixin, AutomaticKeepAliveClientMixin {
  int teamId = 1;

  @override
  bool get wantKeepAlive => true;
  late Box box;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Hive.openBox<Team>('teams');
      box = Hive.box<Team>('teams')..clear();
    });
    ref.read(playerNumberProvider.notifier).state = 4;
  }

  final List<DropdownMenuEntry<int>> colorEntries = <DropdownMenuEntry<int>>[
    DropdownMenuEntry(value: 4, label: '4'),
    DropdownMenuEntry(value: 6, label: '6'),
    DropdownMenuEntry(value: 8, label: '8')
  ];
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<GlobalKey<FormBuilderState>> formTeamKeys = List.generate(
        ref.watch(playerNumberProvider) ~/ 2,
        (i) => GlobalKey<FormBuilderState>());
    List<GlobalKey<FormBuilderState>> formPlayerKeys = List.generate(
        ref.watch(playerNumberProvider) ~/ 2,
        (i) => GlobalKey<FormBuilderState>());
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Row(
                children: [
                  Text('Igraca: ',
                      style: TextStyle(fontSize: 16, color: AppColors.white)),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.125,
                    child: DropdownButtonFormField(
                        iconEnabledColor: AppColors.white,
                        dropdownColor: AppColors.englishVioletDarker,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.coral, width: 3),
                          ),
                        ),
                        value: 4,
                        onChanged: (value) {},
                        validator: (value) {},
                        items: [
                          DropdownMenuItem(
                              alignment: AlignmentDirectional.center,
                              value: 4,
                              child: Text('4')),
                          DropdownMenuItem(value: 6, child: Text('6')),
                          DropdownMenuItem(value: 8, child: Text('8')),
                          DropdownMenuItem(value: 10, child: Text('10'))
                        ]),
                  ),
                ],
              ),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Text('Upišite svoje timove'),
              Text('Nasumični timovi'),
            ],
          ),
          backgroundColor: AppColors.englishVioletLighter,
          elevation: 5,
          automaticallyImplyLeading: false,
          title: const Row(
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
        ),
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.englishVioletDarker,
        body: TabBarView(
          children: [
            GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SizedBox(height: 30),
                    const SizedBox(height: 10),
                    // FormBuilderChoiceChip(
                    //   backgroundColor: AppColors.white,
                    //   onChanged: (value) {
                    //     ref.read(playerNumberProvider.notifier).state = value!;
                    //   },
                    //   alignment: WrapAlignment.center,
                    //   spacing: 10,
                    //   initialValue: 4,
                    //   name: 'players',
                    //   options: const [
                    //     FormBuilderChipOption(
                    //       value: 4,
                    //       child: Row(
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           Text('4',
                    //               style: AppStyles.text20VioletDarkerBold),
                    //           Icon(Icons.person),
                    //         ],
                    //       ),
                    //     ),
                    //     FormBuilderChipOption(
                    //       value: 6,
                    //       child: Row(
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           Text('6',
                    //               style: AppStyles.text20VioletDarkerBold),
                    //           Icon(Icons.person),
                    //         ],
                    //       ),
                    //     ),
                    //     FormBuilderChipOption(
                    //       value: 8,
                    //       child: Row(
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           Text('8',
                    //               style: AppStyles.text20VioletDarkerBold),
                    //           Icon(Icons.person),
                    //         ],
                    //       ),
                    //     ),
                    //     FormBuilderChipOption(
                    //       value: 10,
                    //       child: Row(
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           Text('10',
                    //               style: AppStyles.text20VioletDarkerBold),
                    //           Icon(Icons.person),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: ref.watch(playerNumberProvider) ~/ 2,
                          itemBuilder: (context, index) =>
                              TeamCard(formTeamKeys[index], index, 5),
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
                                validateForms(
                                    context, ref, formTeamKeys, box, teamId);
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
            GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SizedBox(height: 30),
                    const SizedBox(height: 10),
                    // FormBuilderChoiceChip(
                    //   backgroundColor: AppColors.white,
                    //   onChanged: (value) {
                    //     ref.read(playerNumberProvider.notifier).state = value!;
                    //   },
                    //   alignment: WrapAlignment.center,
                    //   spacing: 10,
                    //   initialValue: 4,
                    //   name: 'players',
                    //   options: const [
                    //     FormBuilderChipOption(
                    //       value: 4,
                    //       child: Row(
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           Text('4',
                    //               style: AppStyles.text20VioletDarkerBold),
                    //           Icon(Icons.person),
                    //         ],
                    //       ),
                    //     ),
                    //     FormBuilderChipOption(
                    //       value: 6,
                    //       child: Row(
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           Text('6',
                    //               style: AppStyles.text20VioletDarkerBold),
                    //           Icon(Icons.person),
                    //         ],
                    //       ),
                    //     ),
                    //     FormBuilderChipOption(
                    //       value: 8,
                    //       child: Row(
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           Text('8',
                    //               style: AppStyles.text20VioletDarkerBold),
                    //           Icon(Icons.person),
                    //         ],
                    //       ),
                    //     ),
                    //     FormBuilderChipOption(
                    //       value: 10,
                    //       child: Row(
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           Text('10',
                    //               style: AppStyles.text20VioletDarkerBold),
                    //           Icon(Icons.person),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: ref.watch(playerNumberProvider) ~/ 2,
                          itemBuilder: (context, index) =>
                              PlayerCard(formPlayerKeys[index], index, 5),
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
                                validateForms(
                                    context, ref, formPlayerKeys, box, teamId);
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
          ],
        ),
      ),
    );
  }
}
