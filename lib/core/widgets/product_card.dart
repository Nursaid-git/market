import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String imagePath;

  const ProductCard({super.key, required this.title, required this.price, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(imagePath, fit: BoxFit.cover, height: 200, width: double.infinity),
            ),
            const Positioned(
              top: 10, right: 10,
              child: Icon(Icons.favorite_border, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
        Text(price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }
}