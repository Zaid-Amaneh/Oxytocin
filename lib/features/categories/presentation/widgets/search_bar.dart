import 'package:flutter/material.dart';

class CategorySearchBar extends StatelessWidget {
  final ValueChanged<String>? onChanged;

  const CategorySearchBar({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
       
        Expanded(
          child: Container(
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: Color(0xFF344CB7), width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              onChanged: onChanged,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
                fontFamily: 'GESSUniqueBold',
              ),
              decoration: InputDecoration(
                hintText: "ابحث باسم الطبيب أو التخصص...",
                hintStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Almarai',
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                suffixIcon: Icon(
                  Icons.search,
                  color: Color(0xFF344CB7),
                  size: 28,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        // أيقونة السهم للخلف
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFF344CB7),
              size: 28,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ],
    );
  }
}
