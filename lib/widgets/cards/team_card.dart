import 'package:asoscijacije_nove/constants/app_colors.dart';
import 'package:asoscijacije_nove/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TeamCard extends StatefulWidget {
  const TeamCard(this.formKey, this.index, this.height, {super.key});

  final double height;
  final int index;
  final GlobalKey<FormBuilderState> formKey;

  @override
  State<TeamCard> createState() => _TeamCardState();
}

class _TeamCardState extends State<TeamCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.225,
      child: Card(
        elevation: 5,
        child: Container(
          decoration: AppStyles.containerGradientViolet.copyWith(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: AppColors.englishVioletMoreLighter, width: 3)),
          child: FormBuilder(
            onChanged: () {
              widget.formKey.currentState!.save();
            },
            key: widget.formKey,
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
                        '${AppLocalizations.of(context)!.tim} ${widget.index + 1}',
                        style: AppStyles.text30WhiteBold,
                      ),
                      const Text(
                        '.',
                        style: AppStyles.text30CoralBold,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
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
                        decoration: InputDecoration(
                          focusedErrorBorder: AppStyles.focusedErrorBorder,
                          errorBorder: AppStyles.errorBorder,
                          label: Text(AppLocalizations.of(context)!.ime1Igraca),
                          labelStyle: const TextStyle(color: AppColors.white),
                          errorStyle: const TextStyle(color: AppColors.coral),
                          contentPadding: const EdgeInsets.only(left: 10),
                          enabledBorder: AppStyles.enabledBorder,
                          focusedBorder: AppStyles.focusedBorder,
                        ),
                        name: 'player1',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!
                                .unesiteImeIgraca;
                          }

                          return null;
                        },
                      )),
                      const SizedBox(width: 20),
                      Expanded(
                          child: FormBuilderTextField(
                        style: const TextStyle(
                            color: AppColors.englishVioletMoreLighter),
                        name: 'player2',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!
                                .unesiteImeIgraca;
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                          focusedErrorBorder: AppStyles.focusedErrorBorder,
                          errorBorder: AppStyles.errorBorder,
                          label: Text(AppLocalizations.of(context)!.ime2Igraca),
                          labelStyle: const TextStyle(color: AppColors.white),
                          errorStyle: const TextStyle(color: AppColors.coral),
                          contentPadding: const EdgeInsets.only(left: 10),
                          enabledBorder: AppStyles.enabledBorder,
                          focusedBorder: AppStyles.focusedBorder,
                        ),
                      )),
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
