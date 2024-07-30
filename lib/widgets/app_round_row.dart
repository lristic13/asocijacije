import 'package:asoscijacije_nove/constants/app_styles.dart';
import 'package:flutter/material.dart';

class AppRoundRow extends StatelessWidget {
  const AppRoundRow({
    super.key,
    required this.roundName,
    required this.roundLength,
  });
  final String roundName;
  final int roundLength;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(roundName,
            style: AppStyles.text20WhiteNormal.copyWith(fontSize: 16)),
        Text('${roundLength}s',
            style: AppStyles.text20WhiteNormal.copyWith(fontSize: 16)),
      ],
    );
  }
}
