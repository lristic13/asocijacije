import 'package:asocijacije_nove/constants/app_colors.dart';
import 'package:asocijacije_nove/constants/app_styles.dart';
import 'package:asocijacije_nove/l10n/app_localizations.dart';
import 'package:asocijacije_nove/widgets/app_page_header.dart';
import 'package:asocijacije_nove/widgets/buttons/base-buttons/app_button_full.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'instruction_item.dart';

class InstructionsPage extends StatelessWidget {
  const InstructionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        color: AppColors.englishVioletDarker,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 40,
            bottom: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              AppPageHeader(
                title: AppLocalizations.of(context)!.uputstvaZaIgru,
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
              InstructionItem(
                titleText: AppLocalizations.of(context)!.jedanNaJedan,
                bodyText: AppLocalizations.of(context)!.jedanNaJedanUput,
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
                  Text(
                    AppLocalizations.of(context)!.napomena,
                    style: AppStyles.text15CoralBold,
                  ),
                  Text(
                    AppLocalizations.of(context)!.napomenaTekst,
                    style: AppStyles.text15WhiteBold,
                  ),
                ],
              ),
              const Spacer(flex: 3),
              AppButtonFull(
                buttonText: AppLocalizations.of(context)!.nazad,
                fillColor: AppColors.coral,
                textColor: AppColors.englishViolet,
                onPressed: () => Navigator.pop(context),
              ),
              FutureBuilder<PackageInfo>(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final info = snapshot.data!;
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                        child: Text(
                          'v${info.version}+${info.buildNumber}',
                          style: AppStyles.text15WhiteNormal.copyWith(
                            color: AppColors.englishVioletMoreLighter,
                          ),
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
