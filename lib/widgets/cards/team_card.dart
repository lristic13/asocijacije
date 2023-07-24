import 'package:asoscijacije_nove/constants/app_strings.dart';
import 'package:asoscijacije_nove/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

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
      height: 150,
      child: Card(
        child: Container(
          decoration: AppStyles.containerGradientWhite
              .copyWith(borderRadius: BorderRadius.circular(12)),
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
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    'Tim ${widget.index + 1}',
                    style: AppStyles.text25VioletBold,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, left: 20, right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                          child: FormBuilderTextField(
                        name: 'player1',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.unesiteImeIgraca;
                          }

                          return null;
                        },
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            hintText: AppStrings.imeIgraca,
                            hintStyle: TextStyle(fontSize: 15)),
                      )),
                      const SizedBox(width: 20),
                      Expanded(
                          child: FormBuilderTextField(
                        name: 'player2',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.unesiteImeIgraca;
                          }

                          return null;
                        },
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            hintText: AppStrings.imeIgraca,
                            hintStyle: TextStyle(fontSize: 15)),
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
