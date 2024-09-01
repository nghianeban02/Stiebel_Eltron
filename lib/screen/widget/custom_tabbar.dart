
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/cores/cores_bloc_cubit.dart';
import '../../config/color.dart';
import 'custom_text.dart';

// ignore: must_be_immutable
class CustomRadioTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  CustomRadioTabBar({
    required this.tabs,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: List.generate(
      tabs.length,
      (index) => Expanded(
        child: RadioListTile<int>(
          value: index,
          groupValue: selectedIndex,
          onChanged: (int? value) {
            if (value != null) {
              onChanged(value);
            }
          },
          title: CustomText().textSize14(
            text: tabs[index],
            color: selectedIndex == index ? AppColors.text : AppColors.hintText,
          ),
          activeColor: AppColors.primary,
        ),
      ),
    ),
  );
}
}
