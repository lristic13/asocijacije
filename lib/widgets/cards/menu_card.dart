import 'package:asoscijacije_nove/constants/app_colors.dart';
import 'package:asoscijacije_nove/constants/app_styles.dart';
import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  const MenuCard(
      {this.title,
      this.icon,
      this.colors,
      this.alignment = CrossAxisAlignment.start,
      this.rowAlignment,
      required this.onTap,
      super.key});

  final String? title;
  final Icon? icon;
  final List<Color>? colors;
  final CrossAxisAlignment? alignment;
  final MainAxisAlignment? rowAlignment;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                colors?[0] ?? AppColors.white,
                colors?[1] ?? AppColors.whiteDarker,
              ],
            ),
          ),
          height: 130,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: alignment!,
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: icon),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 15, right: 20),
                child: Material(
                  type: MaterialType.transparency,
                  child: Row(
                    mainAxisAlignment: rowAlignment ?? MainAxisAlignment.start,
                    children: [
                      Text(
                        title ?? '',
                        style: AppStyles.text25VioletBold,
                      ),
                      const Text(
                        '.',
                        style: AppStyles.text25CoralBold,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
