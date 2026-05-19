import 'package:flutter/material.dart';

class SizeSelector extends StatelessWidget {
  final List<String> sizes = ['S', 'M', 'L', 'XL', '2XL'];
  final String selectedSize;
  final Function(String) onSizeSelected;

  SizeSelector({super.key, required this.selectedSize, required this.onSizeSelected});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: sizes.map((size) {
        bool isSelected = size == selectedSize;
        return GestureDetector(
          onTap: () => onSizeSelected(size),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF9775FA) : const Color(0xFFF5F6F7),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(
              size,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}