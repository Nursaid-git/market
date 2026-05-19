import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final bool isVerified; // Для показа зеленой галочки справа

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.isVerified = false,
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
            hintText: hintText,
            suffixIcon: isVerified
                ? const Icon(Icons.check, color: Colors.green)
                : (isPassword ? const Text("Strong", style: TextStyle(color: Colors.green, fontSize: 11)) : null),
            suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          ),
        ),
      ],
    );
  }
}
