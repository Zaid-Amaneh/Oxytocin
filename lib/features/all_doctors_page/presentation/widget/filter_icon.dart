import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_images.dart';

class FilterIcon extends StatelessWidget {
  const FilterIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showFilterSheet(context),
      child: Container(
        margin: const EdgeInsets.only(left: 8, right: 8),
        width: 50,
        height: 50,
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: OvalBorder(
            side: BorderSide(width: 1, color: Color(0xFFE7E7E7)),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 2,
              offset: Offset(0, 2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Image.asset(AppImages.setting),
      ),
    );
  }
}

void showFilterSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      String selectedGender = 'غير محدد';
      double selectedDistance = 10;
      String selectedSpecialty = 'غير محدد';
      String sortBy = 'غير محدد';
      String sortOrder = 'تصاعدي';

      final List<String> genders = ['غير محدد', 'ذكر', 'أنثى'];
      final List<String> specialties = [
        'غير محدد',
        'طب عام',
        'جلدية',
        'أسنان',
        'عيون',
      ];
      final List<String> sortOptions = [
        'غير محدد',
        'الخبرة',
        'التقييم',
        'البعد',
      ];
      final List<String> orderOptions = ['تصاعدي', 'تنازلي'];

      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              children: [
                const Text(
                  'فلترة حسب الجنس',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  spacing: 18.0,
                  children: genders.map((gender) {
                    return ChoiceChip(
                      label: Text(gender),
                      selected: selectedGender == gender,
                      onSelected: (_) =>
                          setState(() => selectedGender = gender),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 20),

                const Text(
                  'فلترة حسب التخصص',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: selectedSpecialty,
                  isExpanded: true,
                  onChanged: (value) {
                    setState(() {
                      selectedSpecialty = value!;
                    });
                  },
                  items: specialties.map((label) {
                    return DropdownMenuItem<String>(
                      value: label,
                      child: Text(label),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 20),

                Text(
                  'البعد (كم): ${selectedDistance.toInt()}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Slider(
                  min: 1,
                  max: 50,
                  value: selectedDistance,
                  divisions: 49,
                  label: '${selectedDistance.toInt()} كم',
                  onChanged: (value) {
                    setState(() {
                      selectedDistance = value;
                    });
                  },
                ),

                const SizedBox(height: 20),

                const Text(
                  'الترتيب حسب',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: sortBy,
                  isExpanded: true,
                  onChanged: (value) {
                    setState(() {
                      sortBy = value!;
                    });
                  },
                  items: sortOptions.map((label) {
                    return DropdownMenuItem<String>(
                      value: label,
                      child: Text(label),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 10),

                const Text(
                  'نوع الترتيب',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  spacing: 8.0,
                  children: orderOptions.map((order) {
                    return ChoiceChip(
                      label: Text(order),
                      selected: sortOrder == order,
                      onSelected: (_) => setState(() => sortOrder = order),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.filter_alt),
                  label: const Text('تطبيق'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
