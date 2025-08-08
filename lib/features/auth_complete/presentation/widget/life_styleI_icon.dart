import 'package:flutter/material.dart';

class LifestyleIcon extends StatelessWidget {
  final String image;
  final bool isSelected;
  final VoidCallback onTap;
  const LifestyleIcon({
    super.key,
    required this.image,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // final double size = isSelected ? 85 : 73;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 73,
        height: 73,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? Border.all(color: Color(0xFF002147), width: 2) // كحلي غامق
              : null,

        ),
        child: Center(
          child: Image.asset(image, width: 83, height: 83, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
