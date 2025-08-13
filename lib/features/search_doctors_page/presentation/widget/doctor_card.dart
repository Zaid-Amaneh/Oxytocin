import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/features/search_doctors_page/data/models/doctor_model.dart';
import 'package:shimmer/shimmer.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({super.key, required this.doctorModel});
  final DoctorModel doctorModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  imageUrl: doctorModel.user.image,
                  imageBuilder: (context, imageProvider) =>
                      CircleAvatar(radius: 30, backgroundImage: imageProvider),
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                  errorWidget: (context, url, error) => const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.error, color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${doctorModel.user.firstName} ${doctorModel.user.lastName}",
                      style: AppStyles.almaraiBold(
                        context,
                      ).copyWith(fontSize: 12, color: AppColors.textPrimary),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      Helper.isArabic(context)
                          ? doctorModel.mainSpecialty.specialty.nameAr
                          : doctorModel.mainSpecialty.specialty.nameEn,
                      style: AppStyles.almaraiBold(
                        context,
                      ).copyWith(fontSize: 10, color: AppColors.textPrimary),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              doctorModel.mainSpecialty.university,
              style: AppStyles.almaraiBold(
                context,
              ).copyWith(fontSize: 12, color: AppColors.textSecondary),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${doctorModel.rate}/5',
                          style: AppStyles.almaraiBold(context).copyWith(
                            fontSize: 12,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4, right: 4),
                          child: SvgPicture.asset(
                            AppImages.starSolid,
                            height: 14,
                            width: 14,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${doctorModel.rates} ${context.tr.reviews}',
                      style: AppStyles.almaraiBold(
                        context,
                      ).copyWith(fontSize: 12, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const ShapeDecoration(
                    shape: OvalBorder(),
                    color: Color(0xFFDAE7FF),
                  ),
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(3.1416),
                    child: const Icon(
                      Icons.arrow_outward,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
