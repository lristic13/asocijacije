import 'package:asoscijacije_nove/constants/app_colors.dart';
import 'package:asoscijacije_nove/constants/app_strings.dart';
import 'package:asoscijacije_nove/constants/app_styles.dart';
import 'package:asoscijacije_nove/widgets/buttons/app_button_full.dart';
import 'package:flutter/material.dart';

import 'instruction_item.dart';

class InstructionsPage extends StatelessWidget {
  const InstructionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: AppStyles.containerGradientViolet,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                AppStrings.uputstvaZaIgru,
                style: AppStyles.text25WhiteBold,
              ),
              const SizedBox(height: 30),
              const Spacer(),
              const InstructionItem(
                titleText: AppStrings.normalnaRunda,
                bodyText: AppStrings.normalnaRundaUput,
              ),
              const SizedBox(height: 30),
              const InstructionItem(
                titleText: AppStrings.jednaRecRunda,
                bodyText: AppStrings.jednaRecRundaUput,
              ),
              const SizedBox(height: 30),
              const InstructionItem(
                titleText: AppStrings.pantomimaRunda,
                bodyText: AppStrings.pantomimaRundaUput,
              ),
              const SizedBox(height: 30),
              const Text(
                AppStrings.rezultatUput,
                style: TextStyle(color: AppColors.white),
              ),
              const SizedBox(height: 10),
              const Text(
                AppStrings.odustajanjeUput,
                style: TextStyle(color: AppColors.white),
              ),
              const Spacer(flex: 3),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: AppButtonFull(
                  buttonText: AppStrings.nazad,
                  fillColor: AppColors.coral,
                  textColor: AppColors.englishViolet,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
