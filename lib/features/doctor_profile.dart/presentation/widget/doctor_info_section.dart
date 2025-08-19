import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/features/doctor_profile.dart/data/models/sub_specialty_model.dart';

class DoctorInfoSection extends StatelessWidget {
  const DoctorInfoSection({
    super.key,
    required this.placeOfStudy,
    required this.about,
    required this.age,
    required this.gender,
    required this.subSpecialty,
  });
  final String placeOfStudy, about, gender;
  final int age;
  final List<SubSpecialtyModel> subSpecialty;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr.aboutDoctor,
            style: AppStyles.almaraiBold(
              context,
            ).copyWith(color: AppColors.textPrimary, fontSize: 18),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr.placeStudy,
                style: AppStyles.almaraiBold(
                  context,
                ).copyWith(color: AppColors.textPrimary, fontSize: 18),
              ),
              Text(
                placeOfStudy,
                style: AppStyles.almaraiRegular(
                  context,
                ).copyWith(color: AppColors.textSecondary, fontSize: 16),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr.about,
                style: AppStyles.almaraiBold(
                  context,
                ).copyWith(color: AppColors.textPrimary, fontSize: 18),
              ),
              Text(
                about,
                style: AppStyles.almaraiRegular(
                  context,
                ).copyWith(color: AppColors.textSecondary, fontSize: 16),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr.genderHint,
                style: AppStyles.almaraiBold(
                  context,
                ).copyWith(color: AppColors.textPrimary, fontSize: 18),
              ),
              Text(
                gender,
                style: AppStyles.almaraiRegular(
                  context,
                ).copyWith(color: AppColors.textSecondary, fontSize: 16),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr.age,
                style: AppStyles.almaraiBold(
                  context,
                ).copyWith(color: AppColors.textPrimary, fontSize: 18),
              ),
              Text(
                age.toString(),
                style: AppStyles.almaraiRegular(
                  context,
                ).copyWith(color: AppColors.textSecondary, fontSize: 16),
              ),
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr.subspecialties,
                style: AppStyles.almaraiBold(
                  context,
                ).copyWith(color: AppColors.textPrimary, fontSize: 18),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: List.generate(subSpecialty.length, (index) {
                  String name = Helper.isArabic(context)
                      ? subSpecialty[index].specialty.nameAr
                      : subSpecialty[index].specialty.nameEn;
                  return Text(
                    index == subSpecialty.length - 1 ? name : "$name|",
                    style: AppStyles.almaraiRegular(
                      context,
                    ).copyWith(color: AppColors.textSecondary, fontSize: 16),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
