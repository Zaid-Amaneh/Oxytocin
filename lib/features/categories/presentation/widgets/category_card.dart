import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String iconAsset; // SVG asset path
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.iconAsset,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    print('CategoryCard - Title: $title, IconAsset: $iconAsset');
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90,
        height: 90,
        margin: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: const Color(0xFF344CB7),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.12),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
            // ظل إضافي من تحت لتحسين المظهر
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 8),
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // محاولة عرض SVG مع fallback إلى أيقونة
            SvgPicture.asset(
              iconAsset,
              width: 48,
              height: 48,
              color: Colors.white,
              placeholderBuilder: (BuildContext context) {
                print('Failed to load SVG: $iconAsset, showing fallback icon');
                return const Icon(
                  Icons.medical_services,
                  size: 48,
                  color: Colors.white,
                );
              },
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                fontFamily: 'AlmaraiRegular',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
