import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomTextButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: const Size(50, 30),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.red,
            fontWeight: .w500,
            fontSize: 15,
          ),
        ));
  }
}
