import 'package:asocijacije_nove/constants/app_colors.dart';
import 'package:asocijacije_nove/constants/app_styles.dart';
import 'package:asocijacije_nove/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

/// Team color rotation: Team Alpha = magenta, Team Beta = cyan, then orange /
/// violet for additional teams.
const List<Color> kTeamColors = [
  AppColors.magenta,
  AppColors.cyan,
  AppColors.orange,
  AppColors.violet,
  AppColors.tiffanyBlue,
];

Color teamColorFor(int index) => kTeamColors[index % kTeamColors.length];

class TeamCard extends StatelessWidget {
  const TeamCard(this.formKey, this.index, this.height, {super.key});

  final double height;
  final int index;
  final GlobalKey<FormBuilderState> formKey;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final color = teamColorFor(index);

    return FormBuilder(
      onChanged: () => formKey.currentState!.save(),
      key: formKey,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: color.withValues(alpha: 0.33), width: 1.5),
          boxShadow: [
            BoxShadow(color: color.withValues(alpha: 0.13), blurRadius: 18),
          ],
        ),
        padding: const EdgeInsets.all(13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                    boxShadow: [BoxShadow(color: color, blurRadius: 10)],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FormBuilderTextField(
                    name: 'teamName',
                    style: NeonText.display(size: 17, color: AppColors.ink),
                    cursorColor: color,
                    decoration: _fieldDecoration(
                      '${localizations.imeTima} ${index + 1}',
                      filled: false,
                    ),
                    validator: (value) =>
                        (value == null || value.isEmpty)
                            ? localizations.unesiteImeTima
                            : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 9),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _playerField(
                    'player1',
                    localizations.ime1Igraca,
                    localizations.unesiteImeIgraca,
                    color,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _playerField(
                    'player2',
                    localizations.ime2Igraca,
                    localizations.unesiteImeIgraca,
                    color,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _playerField(
    String name,
    String label,
    String errorText,
    Color color,
  ) {
    return FormBuilderTextField(
      name: name,
      style: NeonText.body(size: 12.5, weight: FontWeight.w600, color: AppColors.ink),
      cursorColor: color,
      decoration: _fieldDecoration(label, filled: true),
      validator: (value) =>
          (value == null || value.isEmpty) ? errorText : null,
    );
  }

  InputDecoration _fieldDecoration(String label, {required bool filled}) {
    return InputDecoration(
      isDense: true,
      filled: filled,
      fillColor: Colors.black.withValues(alpha: 0.25),
      hintText: label,
      hintStyle: NeonText.body(
        size: 12.5,
        weight: FontWeight.w600,
        color: AppColors.sub,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
      errorStyle: NeonText.body(size: 10, color: AppColors.magenta),
      border: filled
          ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: BorderSide.none,
            )
          : InputBorder.none,
      enabledBorder: filled
          ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: BorderSide.none,
            )
          : InputBorder.none,
      focusedBorder: filled
          ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(color: AppColors.violet, width: 1.5),
            )
          : const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.violet, width: 1.5),
            ),
    );
  }
}
