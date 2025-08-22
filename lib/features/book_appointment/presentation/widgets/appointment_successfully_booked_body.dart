import 'dart:io';
import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/widgets/custom_button.dart';
import 'package:oxytocin/core/widgets/sliver_spacer.dart';
import 'package:oxytocin/features/book_appointment/presentation/widgets/upload_files_widget.dart';

class AppointmentSuccessfullyBookedBody extends StatefulWidget {
  const AppointmentSuccessfullyBookedBody({super.key});

  @override
  State<AppointmentSuccessfullyBookedBody> createState() =>
      _AppointmentSuccessfullyBookedBodyState();
}

class _AppointmentSuccessfullyBookedBodyState
    extends State<AppointmentSuccessfullyBookedBody>
    with SingleTickerProviderStateMixin {
  List<File> uploadedFiles = [];
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.2, 1.0, curve: Curves.easeOutBack),
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onFilesSelected(List<File> files) {
    setState(() {
      uploadedFiles = files;
    });
  }

  void _handleBackToHome() {
    // Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          uploadedFiles.isNotEmpty
              ? 'تم رفع ${uploadedFiles.length} ملفات بنجاح'
              : 'تم حجز موعدك بنجاح',
          style: AppStyles.almaraiBold(
            context,
          ).copyWith(color: Colors.white, fontSize: 14),
        ),
        backgroundColor: const Color(0xFF38A169),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;

    return CustomScrollView(
      slivers: [
        SliverSpacer(height: screenHeight * 0.03),
        SliverToBoxAdapter(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    spacing: 20,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF38A169).withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFF38A169,
                              ).withValues(alpha: 0.2),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          AppImages.successfully,
                          width: 80,
                          height: 80,
                        ),
                      ),
                      Text(
                        context.tr.appointment_success,
                        style: AppStyles.almaraiBold(context).copyWith(
                          color: AppColors.kPrimaryColor1,
                          fontSize: 24,
                          height: 1.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          context.tr.thank_you_message,
                          style: AppStyles.almaraiBold(context).copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 16,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SliverSpacer(height: 30),
        SliverToBoxAdapter(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                      border: Border.all(
                        color: AppColors.kPrimaryColor1.withValues(alpha: 0.1),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.kPrimaryColor1,
                                AppColors.kPrimaryColor1.withValues(alpha: 0.8),
                              ],
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Icon(
                                  Icons.person_rounded,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "د. أحمد الزين",
                                      style: AppStyles.almaraiBold(context)
                                          .copyWith(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "طب الأسنان",
                                      style: AppStyles.almaraiBold(context)
                                          .copyWith(
                                            color: Colors.white.withValues(
                                              alpha: 0.9,
                                            ),
                                            fontSize: 16,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.verified_rounded,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              _buildModernInfoRow(
                                context,
                                icon: Icons.calendar_today_rounded,
                                iconColor: const Color(0xFF3182CE),
                                title: context.tr.date,
                                subtitle: "الثلاثاء، 12 أغسطس",
                              ),
                              const SizedBox(height: 16),
                              _buildModernInfoRow(
                                context,
                                icon: Icons.access_time_rounded,
                                iconColor: const Color(0xFF38A169),
                                title: context.tr.time,
                                subtitle: "3:30 مساءً",
                              ),
                              const SizedBox(height: 16),
                              _buildModernInfoRow(
                                context,
                                icon: Icons.location_on_rounded,
                                iconColor: const Color(0xFFE53E3E),
                                title: context.tr.location,
                                subtitle: "مركز الشفاء الطبي",
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFF38A169,
                            ).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(
                                0xFF38A169,
                              ).withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF38A169),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                context.tr.appointment_confirmed,
                                style: AppStyles.almaraiBold(context).copyWith(
                                  color: const Color(0xFF38A169),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        const SliverSpacer(height: 40),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  context.tr.attach_files_hint,
                  style: AppStyles.almaraiBold(context).copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              UploadFilesWidget(
                maxFiles: 5,
                maxFileSizeInMB: 7,
                onFilesSelected: _onFilesSelected,
              ),
            ],
          ),
        ),

        const SliverSpacer(height: 30),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomButton(
              borderRadius: 25,
              onTap: _handleBackToHome,
              borderColor: AppColors.kPrimaryColor1,
              data: context.tr.backToHome,
              style: AppStyles.almaraiBold(
                context,
              ).copyWith(color: AppColors.background, fontSize: 16),
              visible: true,
              padding: const EdgeInsets.all(18),
            ),
          ),
        ),

        const SliverSpacer(height: 30),
      ],
    );
  }

  Widget _buildModernInfoRow(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppStyles.almaraiBold(context).copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: AppStyles.almaraiBold(context).copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
