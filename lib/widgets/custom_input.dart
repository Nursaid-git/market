import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final Widget? suffix;
  final int? maxLines;

  const CustomInput({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    this.suffix,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
        TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: suffix,
            suffixIconConstraints: const BoxConstraints(minWidth: 0),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFF5F6F7)),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
