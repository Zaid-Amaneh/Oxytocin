import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/features/all_doctors_page/presentation/widget/filter_icon.dart';

class AllDoctorsViewBodyHeader extends StatelessWidget {
  const AllDoctorsViewBodyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height * 0.07),
        Row(
          children: [
            const FilterIcon(),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  showSearch(
                    context: context,
                    delegate: DoctorSearchDelegate(
                      doctors: ['أحمد', 'ليلى', 'خالد', 'يارا'],
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 8, right: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFFA6A6A6),
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    shadows: [
                      const BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Text(
                        'ابحث عن الطبيب المناسب لك',
                        style: AppStyles.almaraiBold(
                          context,
                        ).copyWith(fontSize: 14, color: AppColors.textPrimary),
                      ),
                      const Spacer(),
                      SvgPicture.asset(AppImages.search),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.fromLTRB(64, 15, 10, 6),
          child: Text(
            "استكشف الأطباء واختر الأنسب لك",
            style: AppStyles.almaraiBold(
              context,
            ).copyWith(color: AppColors.textPrimary, fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(64, 0, 10, 10),
          child: Text(
            "اطّلع على التخصصات المختلفة، وقيّم الأطباء، واحجز بكل سهولة.",
            style: AppStyles.almaraiBold(
              context,
            ).copyWith(color: AppColors.textSecondary, fontSize: 15),
          ),
        ),
      ],
    );
  }
}

class DoctorSearchDelegate extends SearchDelegate<String> {
  final List<String> doctors;

  DoctorSearchDelegate({required this.doctors});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          },
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return const BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = doctors.where((doctor) => doctor.contains(query)).toList();

    if (results.isEmpty) {
      return const Center(child: Text('لا توجد نتائج'));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final doctor = results[index];
        return ListTile(
          title: Text(doctor),
          onTap: () {
            close(context, doctor); // إغلاق البحث مع النتيجة
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? []
        : doctors
              .where(
                (doctor) => doctor.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }
}
