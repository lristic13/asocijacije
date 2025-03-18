import 'package:asoscijacije_nove/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/all_providers.dart';

class AppLanguagesRow extends ConsumerWidget {
  const AppLanguagesRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildLanguageSelector(ref, 'Srpski', const Locale('sr')),
        const SizedBox(width: 20),
        _buildLanguageSelector(ref, 'English', const Locale('en')),
      ],
    );
  }

  InkWell _buildLanguageSelector(WidgetRef ref, String text, Locale locale) {
    return InkWell(
      onTap: () {
        ref.read(localeProvider.notifier).state = locale;
        locale == const Locale('sr')
            ? ref.read(gameModeProvider.notifier).state = 'Normalan'
            : ref.read(gameModeProvider.notifier).state = 'Normal';
      },
      child: Text(
        text,
        style: ref.watch(localeProvider) != locale
            ? AppStyles.text15WhiteNormal
            : AppStyles.text15CoralBold,
      ),
    );
  }
}
