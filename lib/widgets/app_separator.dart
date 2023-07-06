import 'package:flutter/material.dart';

class AppSeparator extends StatelessWidget {
  const AppSeparator({this.color, super.key});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: color,
      ),
    );
  }
}
