import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/features/doctor_profile.dart/presentation/widget/rate_stars.dart';

class DoctorProfileViewBodyHeader extends StatelessWidget {
  final String doctorName;
  final String imageUrl;
  final double rate;
  final String specialty;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;

  const DoctorProfileViewBodyHeader({
    super.key,
    required this.doctorName,
    required this.imageUrl,
    required this.rate,
    required this.specialty,
    this.onTap,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Container(
      margin:
          margin ??
          EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.01,
          ),
      width: width,
      height: height * 0.23,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(width * 0.03),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(width * 0.03),
            ),
            child: Padding(
              padding: EdgeInsets.all(width * 0.04),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildDoctorImage(width, height),
                  SizedBox(width: width * 0.04),
                  Expanded(child: _buildDoctorInfo(context, width, height)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorImage(double width, double height) {
    final imageSize = width * 0.37;
    return SizedBox(
      width: imageSize,
      height: imageSize,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  const Color(0xFFF8FBFF),
                  AppColors.kPrimaryColor1.withValues(alpha: 0.08),
                ],
                stops: const [0.0, 0.6, 1.0],
              ),
              borderRadius: BorderRadius.circular(width * 0.06),
              boxShadow: [
                BoxShadow(
                  color: AppColors.kPrimaryColor1.withValues(alpha: 0.12),
                  blurRadius: width * 0.04,
                  offset: Offset(0, height * 0.008),
                  spreadRadius: width * 0.008,
                ),
                BoxShadow(
                  color: const Color(0xFF4A90E2).withValues(alpha: 0.06),
                  blurRadius: width * 0.06,
                  offset: Offset(0, height * 0.012),
                  spreadRadius: width * 0.004,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(width * 0.012),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(width * 0.05),
              border: Border.all(
                color: AppColors.kPrimaryColor1.withValues(alpha: 0.15),
                width: width * 0.004,
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withValues(alpha: 0.9),
                  Colors.white.withValues(alpha: 0.7),
                ],
              ),
            ),
            child: Container(
              margin: EdgeInsets.all(width * 0.006),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(width * 0.045),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      width: imageSize,
                      height: imageSize,
                      placeholder: (context, url) => Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFFF8FBFF), Color(0xFFE3F2FD)],
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.medical_services_outlined,
                              color: AppColors.kPrimaryColor1.withValues(
                                alpha: 0.6,
                              ),
                              size: imageSize * 0.25,
                            ),
                            SizedBox(height: height * 0.008),
                            SizedBox(
                              width: width * 0.04,
                              height: width * 0.04,
                              child: CircularProgressIndicator(
                                strokeWidth: width * 0.004,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.kPrimaryColor1.withValues(
                                    alpha: 0.8,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFFF8FBFF), Color(0xFFE3F2FD)],
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.medical_services,
                              color: AppColors.kPrimaryColor1.withValues(
                                alpha: 0.7,
                              ),
                              size: imageSize * 0.3,
                            ),
                            SizedBox(height: height * 0.006),
                            Icon(
                              Icons.person,
                              color: AppColors.kPrimaryColor1.withValues(
                                alpha: 0.5,
                              ),
                              size: imageSize * 0.2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: width * 0.08,
                      bottom: height * 0.08,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * 0.045),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withValues(alpha: 0.4),
                              Colors.white.withValues(alpha: 0.2),
                              Colors.transparent,
                              AppColors.kPrimaryColor1.withValues(alpha: 0.05),
                            ],
                            stops: const [0.0, 0.3, 0.7, 1.0],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: width * 0.005,
            right: width * 0.005,
            child: Container(
              width: width * 0.05,
              height: width * 0.05,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.kPrimaryColor1.withValues(alpha: 0.3),
                  width: width * 0.002,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.kPrimaryColor1.withValues(alpha: 0.2),
                    blurRadius: width * 0.01,
                    offset: Offset(0, height * 0.002),
                  ),
                ],
              ),
              child: Icon(
                Icons.verified,
                color: const Color(0xFF4CAF50),
                size: width * 0.03,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorInfo(BuildContext context, double width, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${context.tr.d}.$doctorName',
          style: AppStyles.almaraiBold(
            context,
          ).copyWith(fontSize: width * 0.05, color: AppColors.textPrimary),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: height * 0.01),
        RateStars(rate: rate, withText: true, starSize: 0.04),
        SizedBox(height: height * 0.01),
        Text(
          specialty,
          style: AppStyles.almaraiBold(
            context,
          ).copyWith(fontSize: width * 0.035, color: AppColors.textSecondary),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
