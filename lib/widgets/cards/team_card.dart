import 'package:asoscijacije_nove/constants/app_colors.dart';
import 'package:asoscijacije_nove/constants/app_styles.dart';
import 'package:asoscijacije_nove/l10n/app_localizations.dart';
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
                color: AppColors.englishVioletMoreLighter,
                width: 3,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: FormBuilderTextField(
                    style: AppStyles.text30WhiteBold,
                    decoration: AppStyles.errorInputDecoration.copyWith(
                      label: Text(
                        '${AppLocalizations.of(context)!.imeTima} ${index + 1}',
                        style: const TextStyle(
                          color: AppColors.englishVioletLighter,
                        ),
                      ),
                    ),
                    name: 'teamName',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.unesiteImeTima;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 15,
                    left: 20,
                    right: 20,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: FormBuilderTextField(
                          style: const TextStyle(
                            color: AppColors.englishVioletMoreLighter,
                          ),
                          decoration: AppStyles.errorInputDecoration.copyWith(
                            label: Text(
                              AppLocalizations.of(context)!.ime1Igraca,
                              style: const TextStyle(
                                color: AppColors.englishVioletLighter,
                              ),
                            ),
                          ),
                          name: 'player1',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(
                                context,
                              )!.unesiteImeIgraca;
                            }

                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: FormBuilderTextField(
                          style: const TextStyle(
                            color: AppColors.englishVioletMoreLighter,
                          ),
                          decoration: AppStyles.errorInputDecoration.copyWith(
                            label: Text(
                              AppLocalizations.of(context)!.ime2Igraca,
                              style: const TextStyle(
                                color: AppColors.englishVioletLighter,
                              ),
                            ),
                          ),
                          name: 'player2',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(
                                context,
                              )!.unesiteImeIgraca;
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
