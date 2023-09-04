import 'package:asoscijacije_nove/constants/app_colors.dart';
import 'package:asoscijacije_nove/constants/app_styles.dart';
import 'package:asoscijacije_nove/widgets/buttons/app_button_full.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.uputstvaZaIgru,
                    style: AppStyles.text30WhiteBold,
                  ),
                  const Text(
                    '.',
                    style: AppStyles.text30CoralBold,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Spacer(),
              InstructionItem(
                titleText: AppLocalizations.of(context)!.normalnaRunda,
                bodyText: AppLocalizations.of(context)!.normalnaRundaUput,
              ),
              const SizedBox(height: 30),
              InstructionItem(
                titleText: AppLocalizations.of(context)!.jednaRecRunda,
                bodyText: AppLocalizations.of(context)!.jednaRecRundaUput,
              ),
              const SizedBox(height: 30),
              InstructionItem(
                titleText: AppLocalizations.of(context)!.pantomimaRunda,
                bodyText: AppLocalizations.of(context)!.pantomimaRundaUput,
              ),
              const SizedBox(height: 30),
              Text(
                AppLocalizations.of(context)!.rezultatUput,
                style: const TextStyle(color: AppColors.white),
              ),
              const SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.odustajanjeUput,
                style: const TextStyle(color: AppColors.white),
              ),
              const SizedBox(height: 10),
              Wrap(
                children: [
                  Text(AppLocalizations.of(context)!.napomena,
                      style: AppStyles.text15CoralBold),
                  Text(AppLocalizations.of(context)!.napomenaTekst,
                      style: AppStyles.text15WhiteBold),
                ],
              ),
              const Spacer(flex: 3),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: AppButtonFull(
                  buttonText: AppLocalizations.of(context)!.nazad,
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
