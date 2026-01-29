import 'package:asocijacije_nove/constants/app_styles.dart';
import 'package:flutter/material.dart';

class InstructionItem extends StatelessWidget {
  const InstructionItem({
    required this.titleText,
    required this.bodyText,
    super.key,
  });

  final String titleText;
  final String bodyText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titleText, style: AppStyles.text20CoralBold),
          Text(bodyText, style: AppStyles.text15WhiteNormal),
        ],
      ),
    );
  }
}
