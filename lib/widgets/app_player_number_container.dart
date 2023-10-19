import 'package:asoscijacije_nove/constants/app_colors.dart';
import 'package:asoscijacije_nove/mixins/forms_mixin.dart';
import 'package:asoscijacije_nove/providers/all_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppPlayerNumberContainer extends StatelessWidget with FormsMixin {
  const AppPlayerNumberContainer(
      {required this.value,
      required this.ref,
      required this.cbOnTap,
      super.key});

  final Function()? cbOnTap;
  final int value;
  final WidgetRef ref;
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: cbOnTap,
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 80,
          width: 70,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.coral, width: 1.5),
              color: value == ref.read(playerNumberProvider) ? AppColors.coral : Colors.transparent,
              borderRadius: BorderRadius.circular(13)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: TextStyle(
                    fontFamily: 'Geologica',
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color:
                        value == ref.read(playerNumberProvider) ? AppColors.englishViolet : AppColors.white),
                child: Text(value.toString()),
              ),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: TextStyle(
                    fontFamily: 'Geologica',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color:
                        value == ref.read(playerNumberProvider) ? AppColors.englishViolet : AppColors.white),
                child: const Text('igrača'),
              ),
            ],
          )),
    );
  }
}
