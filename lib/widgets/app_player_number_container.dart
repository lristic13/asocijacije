import 'package:asocijacije_nove/constants/app_colors.dart';
import 'package:asocijacije_nove/l10n/app_localizations.dart';
import 'package:asocijacije_nove/mixins/forms_mixin.dart';
import 'package:asocijacije_nove/providers/all_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppPlayerNumberContainer extends StatelessWidget with FormsMixin {
  const AppPlayerNumberContainer({
    required this.value,
    required this.ref,
    required this.cbOnTap,
    super.key,
  });

  final Function()? cbOnTap;
  final int value;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: cbOnTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.englishVioletLighter, width: 1.5),
          color: value == ref.read(playerNumberProvider)
              ? AppColors.englishVioletLighter
              : Colors.transparent,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                fontFamily: 'Geologica',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: value == ref.read(playerNumberProvider)
                    ? AppColors.englishVioletDarker
                    : AppColors.white,
              ),
              child: Text(value.toString()),
            ),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                fontFamily: 'Geologica',
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: value == ref.read(playerNumberProvider)
                    ? AppColors.englishVioletDarker
                    : AppColors.white,
              ),
              child: Text(AppLocalizations.of(context)!.igraca),
            ),
          ],
        ),
      ),
    );
  }
}
