import 'package:asoscijacije_nove/constants/app_colors.dart';
import 'package:asoscijacije_nove/constants/app_strings.dart';
import 'package:asoscijacije_nove/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TeamCard extends StatelessWidget {
  const TeamCard(this.formKey, this.index, this.height, {super.key});

  final double height;
  final int index;
  final GlobalKey<FormBuilderState> formKey;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FormBuilder(
        onChanged: () {
          formKey.currentState!.save();
        },
        key: formKey,
        child: Card(
          elevation: 5,
          child: Container(
            decoration: AppStyles.containerGradientViolet.copyWith(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: AppColors.englishVioletMoreLighter, width: 3)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Text(
                        'Tim ${index + 1}',
                        style: AppStyles.text30WhiteBold,
                      ),
                      const Text(
                        '.',
                        style: AppStyles.text30CoralBold,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 20, right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                          child: FormBuilderTextField(
                        style: const TextStyle(
                            color: AppColors.englishVioletMoreLighter),
                        decoration: AppStyles.errorInputDecoration.copyWith(
                          label: const Text(AppStrings.ime1Igraca),
                        ),
                        name: 'player1',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.unesiteImeIgraca;
                          }

                          return null;
                        },
                      )),
                      const SizedBox(width: 20),
                      Expanded(
                        child: FormBuilderTextField(
                          style: const TextStyle(
                              color: AppColors.englishVioletMoreLighter),
                          decoration: AppStyles.errorInputDecoration.copyWith(
                            label: const Text(AppStrings.ime2Igraca),
                          ),
                          name: 'player2',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.unesiteImeIgraca;
                            }

                            return null;
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
    );
  }
}
