import 'package:asocijacije_nove/constants/app_colors.dart';
import 'package:asocijacije_nove/constants/app_styles.dart';
import 'package:asocijacije_nove/l10n/app_localizations.dart';
import 'package:asocijacije_nove/widgets/app_page_header.dart';
import 'package:asocijacije_nove/widgets/app_separator.dart';
import 'package:asocijacije_nove/widgets/buttons/base-buttons/app_button_empty.dart';
import 'package:asocijacije_nove/widgets/neon_background.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'instruction_item.dart';

class InstructionsPage extends StatelessWidget {
  const InstructionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: NeonBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              top: 8,
              bottom: 18,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              AppPageHeader(
                title: AppLocalizations.of(context)!.uputstvaZaIgru,
              ),
              const AppSeparator(color: AppColors.orange),
              const SizedBox(height: 30),
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
                style: NeonText.body(size: 14, color: AppColors.sub),
              ),
              const SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.odustajanjeUput,
                style: NeonText.body(size: 14, color: AppColors.sub),
              ),
              const SizedBox(height: 10),
              Wrap(
                children: [
                  Text(
                    AppLocalizations.of(context)!.napomena,
                    style: NeonText.body(
                      size: 14,
                      weight: FontWeight.w800,
                      color: AppColors.orange,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.napomenaTekst,
                    style: NeonText.body(
                      size: 14,
                      weight: FontWeight.w700,
                      color: AppColors.ink,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              AppButtonEmpty(
                buttonText: AppLocalizations.of(context)!.nazad,
                borderColor: AppColors.ink,
                textColor: AppColors.ink,
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
                          style: NeonText.body(
                            size: 12,
                            weight: FontWeight.w600,
                            color: AppColors.sub,
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
      ),
    );
  }
}
