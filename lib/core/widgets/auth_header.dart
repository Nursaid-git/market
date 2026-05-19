import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String imagePath;
  final String? subtitle;

  const AuthHeader({
    super.key,
    required this.title,
    required this.imagePath,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imagePath, height: 150), // Путь к облаку с замком
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 10),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey, fontSize: 15),
          ),
        ],
      ],
    );
  }
}