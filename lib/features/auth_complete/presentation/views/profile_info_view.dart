import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/constants/app_constants.dart';
import 'package:oxytocin/core/routing/route_names.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/features/auth_complete/presentation/widget/Profile_date_picker_field.dart';
import 'package:oxytocin/features/auth_complete/presentation/widget/custom_input_text_field.dart';
import 'package:oxytocin/core/Utils/size_config.dart';
import 'package:oxytocin/features/auth_complete/presentation/widget/profile_action_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/features/auth_complete/presentation/cubit/profile_info_cubit.dart';
import 'package:oxytocin/features/auth_complete/presentation/cubit/profile_info_state.dart';

class ProfileInfoPage extends StatelessWidget {
  const ProfileInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileInfo();
  }
}

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  DateTime? selectedDate;
  String? gender;
  String? dateError;

  @override
  void dispose() {
    emailController.dispose();
    jobController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale('ar'),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateError = null;
      });
      print('📅 تم اختيار تاريخ الميلاد: $picked');
      context.read<ProfileInfoCubit>().setBirthDate(picked);
      print('✅ تم حفظ تاريخ الميلاد في الكيوبت');
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Builder(
      builder: (context) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: BlocListener<ProfileInfoCubit, ProfileInfoState>(
            listener: (context, state) {
              if (state.isSuccess) {
                context.pushNamed(
                  RouteNames.medicalInfoView,
                  extra: context.read<ProfileInfoCubit>(),
                  // extra: {
                  //   'profileInfoCubit': context.read<ProfileInfoCubit>(),
                  //   // 'birthDate': context
                  //   //     .read<ProfileInfoCubit>()
                  //   //     .state
                  //   //     .birthDate,
                  //   // 'job': context.read<ProfileInfoCubit>().state.job,
                  //   // 'gender': context.read<ProfileInfoCubit>().state.gender,
                  // },
                );
              }
              if (state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage!),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: SizeConfig.screenHigh * 0.03,
                          left: SizeConfig.screenWidth * 0.02,
                        ),
                        child: Image.asset(
                          AppImages.illustration,
                          width: SizeConfig.screenWidth * 0.5,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHigh * 0.02),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.screenWidth * 0.06,
                        ),
                        child: Text(
                          'نرغب بالتعرف عليك أكثر\nفضلًا أكمل بياناتك الشخصية.',
                          style: AppStyles.almaraiBold(context).copyWith(
                            color: AppColors.kPrimaryColor1,
                            fontSize: getResponsiveFontSize(
                              context,
                              fontSize: 18,
                            ),
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHigh * 0.03),
                      Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.04,
                          right: SizeConfig.screenWidth * 0.04,
                        ),
                        child: Column(
                          children: [
                            CustomInputField(
                              controller: emailController,
                              hint: 'البريد الإلكتروني',
                              icon: Icons.email_outlined,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'هذا الحقل مطلوب';
                                }
                                if (!RegExp(
                                  r'^[^@\s]+@[^@\s]+\.[^@\s]+',
                                ).hasMatch(value)) {
                                  return 'يرجى إدخال بريد إلكتروني صحيح';
                                }
                                return null;
                              },
                              horizontalPadding: SizeConfig.screenWidth * 0.06,
                              verticalPadding: SizeConfig.screenHigh * 0.01,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.screenWidth * 0.06,
                                vertical: SizeConfig.screenHigh * 0.01,
                              ),
                              child: DecoratedBox(
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      width: 1,
                                      color: AppColors.textfieldBorder,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      AppConstants.borderRadiusCircular,
                                    ),
                                  ),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x3F000000),
                                      blurRadius: 4,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: DropdownButtonFormField<String>(
                                    value: gender,
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      hintText: 'الجنس',
                                      hintStyle: AppStyles.almaraiBold(context)
                                          .copyWith(
                                            color: AppColors.textPrimary,
                                            fontSize: getResponsiveFontSize(
                                              context,
                                              fontSize: 14,
                                            ),
                                            fontWeight: FontWeight.w900,
                                          ),
                                      border: InputBorder.none,
                                      suffixIcon: const Padding(
                                        padding: EdgeInsets.only(left: 16.0),
                                        child: Icon(
                                          Icons.check,
                                          color: AppColors.kPrimaryColor1,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: SizeConfig.screenHigh * 0.018,
                                        horizontal:
                                            SizeConfig.screenWidth * 0.04,
                                      ),
                                    ),
                                    style: AppStyles.almaraiBold(context)
                                        .copyWith(
                                          color: AppColors.textPrimary,
                                          fontSize: getResponsiveFontSize(
                                            context,
                                            fontSize: 14,
                                          ),
                                          fontWeight: FontWeight.w900,
                                        ),
                                    items: const [
                                      DropdownMenuItem(
                                        value: 'ذكر',
                                        child: Text('ذكر'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'أنثى',
                                        child: Text('أنثى'),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(() => gender = value);
                                      print('👤 تم اختيار الجنس: $value');
                                      context
                                          .read<ProfileInfoCubit>()
                                          .setGender(value!);
                                      print('✅ تم حفظ الجنس في الكيوبت');
                                    },
                                    validator: (value) => value == null
                                        ? 'يرجى اختيار الجنس'
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                            ProfileDatePickerField(
                              label: 'تاريخ الميلاد',
                              selectedDate: selectedDate,
                              onTap: _selectDate,
                              errorText: dateError,
                            ),
                            CustomInputField(
                              controller: jobController,
                              hint: 'الوظيفة الحالية',
                              icon: Icons.work_outline,
                              validator: (value) =>
                                  value == null || value.isEmpty
                                  ? 'هذا الحقل مطلوب'
                                  : null,
                              horizontalPadding: SizeConfig.screenWidth * 0.06,
                              verticalPadding: SizeConfig.screenHigh * 0.01,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHigh * 0.03),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.screenWidth * 0.12,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
                            builder: (context, state) {
                              if (state.isSubmitting) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.kPrimaryColor1,
                                  ),
                                );
                              }
                              return ProfileActionButton(
                                text: 'التالي',
                                onPressed: () {
                                  print('=== حفظ البيانات الشخصية ===');

                                  final cubit = context
                                      .read<ProfileInfoCubit>();

                                  // حفظ الجنس
                                  if (gender != null) {
                                    print('حفظ الجنس: $gender');
                                    cubit.setGender(gender!);
                                  } else {
                                    print('❌ الجنس فارغ');
                                  }

                                  // حفظ تاريخ الميلاد
                                  if (selectedDate != null) {
                                    print('حفظ تاريخ الميلاد: $selectedDate');
                                    cubit.setBirthDate(selectedDate!);
                                  } else {
                                    print('❌ تاريخ الميلاد فارغ');
                                  }

                                  // حفظ المهنة
                                  if (jobController.text.isNotEmpty) {
                                    print('حفظ المهنة: ${jobController.text}');
                                    cubit.setJob(jobController.text);
                                  } else {
                                    print('❌ المهنة فارغة');
                                  }

                                  // طباعة البيانات المحفوظة
                                  print('--- البيانات المحفوظة في State ---');
                                  print('الجنس: ${cubit.state.gender}');
                                  print(
                                    'تاريخ الميلاد: ${cubit.state.birthDate}',
                                  );
                                  print('المهنة: ${cubit.state.job}');

                                  // التحقق من اكتمال البيانات
                                  if (gender != null &&
                                      selectedDate != null &&
                                      jobController.text.isNotEmpty) {
                                    print(
                                      '✅ جميع البيانات مكتملة، الانتقال للصفحة التالية',
                                    );
                                    context.pushNamed(
                                      RouteNames.medicalInfoView,
                                      extra: context.read<ProfileInfoCubit>(),
                                    );
                                  } else {
                                    print('❌ البيانات غير مكتملة');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'يرجى تعبئة جميع الحقول المطلوبة',
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                },
                                filled: true,
                                borderRadius: AppConstants.borderRadiusCircular,
                                fontSize: getResponsiveFontSize(
                                  context,
                                  fontSize: 18,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHigh * 0.04),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
