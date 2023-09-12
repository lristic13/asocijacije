import 'package:asoscijacije_nove/constants/app_colors.dart';
import 'package:asoscijacije_nove/constants/app_strings.dart';
import 'package:asoscijacije_nove/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class PlayerCard extends StatefulWidget {
  const PlayerCard(this.formKey, this.index, this.height, {super.key});

  final double height;
  final int index;
  final GlobalKey<FormBuilderState> formKey;

  @override
  State<PlayerCard> createState() => _TeamCardState();
}

class _TeamCardState extends State<PlayerCard> {
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      onChanged: () {
        widget.formKey.currentState!.save();
      },
      key: widget.formKey,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
        child: Expanded(
            child: FormBuilderTextField(
          style: const TextStyle(color: AppColors.englishVioletMoreLighter),
          decoration: InputDecoration(
            focusedErrorBorder: AppStyles.focusedErrorBorder,
            errorBorder: AppStyles.errorBorder,
            label: Text('Ime ${widget.index + 1}.igrača'),
            labelStyle: const TextStyle(color: AppColors.white),
            errorStyle: const TextStyle(color: AppColors.coral),
            contentPadding: const EdgeInsets.only(left: 10),
            enabledBorder: AppStyles.enabledBorder,
            focusedBorder: AppStyles.focusedBorder,
          ),
          name: 'player',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppStrings.unesiteImeIgraca;
            }

            return null;
          },
        )),
      ),
    );
  }
}
