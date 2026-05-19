import 'package:flutter/material.dart';

import '../theme/colors.dart';

class GenderButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const GenderButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? AppColors.primary : const Color(0xFFF5F6F7),
          foregroundColor: isSelected ? Colors.white : AppColors.greyText,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(vertical: 18),
        ),
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      ),
    );
  }
}