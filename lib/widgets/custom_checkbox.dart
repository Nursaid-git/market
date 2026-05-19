import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/core/theme/colors.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String label;
  const CustomCheckbox({super.key, required this.value, required this.onChanged, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: value,
            onChanged: onChanged,
        activeColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.greyText,
            fontSize: 14
          ),
        )
      ],
    );
  }
}
