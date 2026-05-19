import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String text;
  final String iconPath;
  final Color color;
  final VoidCallback onPressed;

  const SocialButton({
    super.key,
    required this.text,
    required this.iconPath,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 0,
        ),
        onPressed: onPressed,
        icon: Image.asset(iconPath, width: 20, height: 20), 
        label: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}