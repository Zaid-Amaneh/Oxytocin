import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/routing/route_names.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/Utils/size_config.dart';
import 'package:oxytocin/features/auth_complete/presentation/widget/profile_action_button.dart';
import 'package:oxytocin/core/constants/app_constants.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/features/auth_complete/presentation/cubit/profile_info_cubit.dart';
import 'package:oxytocin/features/auth_complete/presentation/cubit/profile_info_state.dart';

class UploadProfilePhoto extends StatefulWidget {
  const UploadProfilePhoto({super.key});

  @override
  State<UploadProfilePhoto> createState() => _UploadProfilePhotoState();
}

class _UploadProfilePhotoState extends State<UploadProfilePhoto> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  void _handleNextButtonPress() {
    if (_selectedImage != null) {
      // رفع الصورة أولاً
      context
          .read<ProfileInfoCubit>()
          .uploadProfileImage(_selectedImage!)
          .then((_) {
            // الانتقال للصفحة التالية بعد نجاح الرفع
            if (mounted) {
              context.pushNamed(RouteNames.congratView);
            }
          })
          .catchError((error) {
            // معالجة الخطأ إذا فشل الرفع
            print('Error uploading image: $error');
          });
    } else {
      // الانتقال مباشرة إذا لم يتم اختيار صورة
      context.pushNamed(RouteNames.congratView);
    }
  }

  VoidCallback? _getNextButtonCallback(ProfileInfoState state) {
    if (state.isSubmitting) {
      return null;
    }
    return () {
      if (_selectedImage != null) {
        context.read<ProfileInfoCubit>().uploadProfileImage(_selectedImage!);

        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            context.pushNamed(RouteNames.congratView);
          }
        });
      } else {
        context.pushNamed(RouteNames.congratView);
      }
    };
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });

        context.read<ProfileInfoCubit>().setProfileImage(_selectedImage!);
      }
    } catch (e) {
      // Handle error
      print('Error picking image: $e');
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '',
            style: AppStyles.almaraiBold(context),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text(
                  'الكاميرا',
                  style: AppStyles.almaraiRegular(context),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text('المعرض', style: AppStyles.almaraiRegular(context)),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return BlocListener<ProfileInfoCubit, ProfileInfoState>(
      listener: (context, state) {
        if (state.isSuccess) {
          context.pushNamed(RouteNames.congratView);
        } else if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'فشل في رفع الصورة: ${state.errorMessage}',
                style: AppStyles.almaraiRegular(context),
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: SizeConfig.screenHigh * 0.05),
                Text(
                  'أضف لمستك الشخصية',
                  style: AppStyles.almaraiBold(context).copyWith(
                    color: AppColors.kPrimaryColor1,
                    fontSize: getResponsiveFontSize(context, fontSize: 20),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHigh * 0.01),
                Text(
                  'يرجى رفع صورتك.',
                  style: AppStyles.almaraiBold(context).copyWith(
                    color: AppColors.kPrimaryColor1,
                    fontSize: getResponsiveFontSize(context, fontSize: 16),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHigh * 0.08),

                GestureDetector(
                  onTap: _showImageSourceDialog,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F3F3),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.kPrimaryColor1.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (_selectedImage != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: Image.file(
                              _selectedImage!,
                              fit: BoxFit.cover,
                              height: SizeConfig.screenWidth * 0.8,
                              width: SizeConfig.screenWidth * 0.8,
                            ),
                          )
                        else
                          Image.asset(
                            AppImages.uploadPhoto,
                            fit: BoxFit.contain,
                            height: SizeConfig.screenWidth * 0.8,
                            width: SizeConfig.screenWidth * 0.8,
                          ),

                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.kPrimaryColor1.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: SizeConfig.screenHigh * 0.015),

                Padding(
                  padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.25),
                  child: Text(
                    'يفضل أن تكون الصورة واضحة  \n وحديثة، وتظهر الوجه بوضوح.',
                    style: AppStyles.almaraiBold(context).copyWith(
                      color: AppColors.textSecondary,
                      fontSize: getResponsiveFontSize(context, fontSize: 13),
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),

                const SizedBox(height: 120),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
                          builder: (context, state) {
                            if (state.isSubmitting) {
                              return ProfileActionButton(
                                text: "التالي",
                                onPressed: () {}, // دالة فارغة بدلاً من null
                                filled: true,
                                borderRadius: 20,
                                fontSize: 16,
                                color: const Color(0xFF000957),
                                height: 56,
                              );
                            } else {
                              return ProfileActionButton(
                                text: "التالي",
                                onPressed: () {
                                  if (_selectedImage != null) {
                                    // رفع الصورة فقط - الانتقال سيتم عبر BlocListener
                                    context
                                        .read<ProfileInfoCubit>()
                                        .uploadProfileImage(_selectedImage!);
                                  } else {
                                    // الانتقال مباشرة إذا لم يتم اختيار صورة
                                    context.pushNamed(RouteNames.congratView);
                                  }
                                },
                                filled: true,
                                borderRadius: 20,
                                fontSize: 16,
                                color: const Color(0xFF000957),
                                height: 56,
                              );
                            }
                          },
                        ),
                      ),

                      const SizedBox(width: 16),

                      Expanded(
                        child: ProfileActionButton(
                          text: "عودة",
                          onPressed: () {
                            context.pop();
                          },
                          filled: true,
                          borderRadius: 20,
                          fontSize: 16,
                          color: const Color(0xFF000957),
                          height: 56,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
