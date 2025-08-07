import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/routing/route_names.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/features/auth_complete/presentation/cubit/profile_info_cubit.dart';
import 'package:oxytocin/features/auth_complete/presentation/widget/custom_input_text_field.dart';
import 'package:oxytocin/features/auth_complete/presentation/widget/life_styleI_icon.dart';
import 'package:go_router/go_router.dart';
import 'package:oxytocin/core/Utils/size_config.dart';
import 'package:oxytocin/features/auth_complete/presentation/widget/profile_action_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/features/auth_complete/presentation/cubit/profile_info_state.dart';

class MedicalInfoBody extends StatefulWidget {
  const MedicalInfoBody(this.bloc, {super.key});
  final ProfileInfoCubit bloc;
  @override
  State<MedicalInfoBody> createState() => _MedicalInfoBodyState();
}

class _MedicalInfoBodyState extends State<MedicalInfoBody> {
  final TextEditingController chronicController = TextEditingController();
  final TextEditingController surgeryController = TextEditingController();
  final TextEditingController allergyController = TextEditingController();
  final TextEditingController medsController = TextEditingController();

  String? selectedBloodType;
  bool isSmoker = false;
  bool isDrinker = false;
  bool isMarried = false;

  final List<Map<String, String>> bloodTypes = [
    {'img': AppImages.imagesAA, 'type': 'A+'},
    {'img': AppImages.imagesA, 'type': 'A-'},
    {'img': AppImages.imagesBb, 'type': 'B+'},
    {'img': AppImages.imagesB, 'type': 'B-'},
    {'img': AppImages.imagesAbb, 'type': 'AB+'},
    {'img': AppImages.imagesAb, 'type': 'AB-'},
    {'img': AppImages.imagesOo, 'type': 'O+'},
    {'img': AppImages.imagesO, 'type': 'O-'},
  ];

  int currentBloodPage = 0;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ProfileInfoCubit>();
    chronicController.text = cubit.state.medicalHistory ?? '';
    surgeryController.text = cubit.state.surgicalHistory ?? '';
    allergyController.text = cubit.state.allergies ?? '';
    medsController.text = cubit.state.medicines ?? '';
    isSmoker = cubit.state.isSmoker;
    isDrinker = cubit.state.isDrinker;
    isMarried = cubit.state.isMarried;

    if (cubit.state.bloodType != null && cubit.state.bloodType!.isNotEmpty) {
      selectedBloodType = cubit.state.bloodType;
      final index = bloodTypes.indexWhere(
        (b) => b['type'] == selectedBloodType,
      );
      if (index != -1) currentBloodPage = index;
    } else {
      selectedBloodType = bloodTypes[0]['type'];
      currentBloodPage = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: SizeConfig.screenHigh * 0.03,
                  left: SizeConfig.screenWidth * 0.06,
                  right: SizeConfig.screenWidth * 0.06,
                ),
                child: Image.asset(
                  AppImages.medicalHistoryd,
                  width: SizeConfig.screenWidth * 0.8,
                  height: SizeConfig.screenHigh * 0.28,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: SizeConfig.screenHigh * 0.01),

              Text(
                'صحتك تهمنا\nنرجى تزويدنا بمعلوماتك الطبية.',
                textAlign: TextAlign.center,
                style: AppStyles.almaraiBold(context).copyWith(
                  color: AppColors.kPrimaryColor1,
                  fontSize: getResponsiveFontSize(context, fontSize: 15),
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: SizeConfig.screenHigh * 0.02),

              CustomInputField(
                controller: chronicController,
                hint: 'الأمراض المزمنة',
                svgIcon: AppImages.illnesses,
                horizontalPadding: SizeConfig.screenWidth * 0.06,
                verticalPadding: SizeConfig.screenHigh * 0.01,
                onChanged: (val) =>
                    context.read<ProfileInfoCubit>().setMedicalHistory(val),
              ),
              CustomInputField(
                controller: surgeryController,
                hint: 'العمليات الجراحية السابقة',
                svgIcon: AppImages.surgeryIcon,
                horizontalPadding: SizeConfig.screenWidth * 0.06,
                verticalPadding: SizeConfig.screenHigh * 0.01,
                onChanged: (val) =>
                    context.read<ProfileInfoCubit>().setSurgicalHistory(val),
              ),
              CustomInputField(
                controller: allergyController,
                hint: 'الحساسية',
                svgIcon: AppImages.sensitive,
                horizontalPadding: SizeConfig.screenWidth * 0.06,
                verticalPadding: SizeConfig.screenHigh * 0.01,
                onChanged: (val) =>
                    context.read<ProfileInfoCubit>().setAllergies(val),
              ),
              CustomInputField(
                controller: medsController,
                hint: 'الأدوية المستخدمة بانتظام',
                svgIcon: AppImages.medicines,
                horizontalPadding: SizeConfig.screenWidth * 0.06,
                verticalPadding: SizeConfig.screenHigh * 0.01,
                onChanged: (val) =>
                    context.read<ProfileInfoCubit>().setMedicines(val),
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.06,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'اختر نوع زمرة دمك',
                    style: AppStyles.almaraiBold(context).copyWith(
                      color: AppColors.kPrimaryColor1,
                      fontSize: getResponsiveFontSize(context, fontSize: 14),
                    ),
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.screenHigh * 0.02),
              SizedBox(
                height: SizeConfig.screenHigh * 0.14,
                width: SizeConfig.screenWidth * 0.9,
                child: PageView.builder(
                  controller: PageController(
                    initialPage: currentBloodPage,
                    viewportFraction: 0.28,
                  ),
                  itemCount: bloodTypes.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentBloodPage = index;
                      selectedBloodType = bloodTypes[index]['type'];
                    });
                    context.read<ProfileInfoCubit>().setBloodType(
                      bloodTypes[index]['type'] ?? '',
                    );
                  },
                  itemBuilder: (context, index) {
                    final isCenter = index == currentBloodPage;
                    final isSide = (index - currentBloodPage).abs() == 1;
                    final double imageSize = isCenter
                        ? SizeConfig.screenWidth * 0.18
                        : SizeConfig.screenWidth * 0.13;
                    return Center(
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: isCenter ? 1.0 : (isSide ? 0.5 : 0.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              currentBloodPage = index;
                              selectedBloodType = bloodTypes[index]['type'];
                            });
                            context.read<ProfileInfoCubit>().setBloodType(
                              bloodTypes[index]['type'] ?? '',
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isCenter
                                  // ignore: deprecated_member_use
                                  ? AppColors.kPrimaryColor1.withOpacity(0.08)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(
                                imageSize * 0.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: isCenter
                                      ? AppColors.kPrimaryColor1.withOpacity(
                                          0.15,
                                        )
                                      : Colors.black12.withOpacity(0.04),
                                  blurRadius: isCenter ? 10 : 2,
                                  spreadRadius: isCenter ? 2 : 0.5,
                                ),
                              ],
                              border: isCenter
                                  ? Border.all(
                                      color: AppColors.kPrimaryColor1,
                                      width: 2,
                                    )
                                  : null,
                            ),
                            child: Image.asset(
                              bloodTypes[index]['img']!,
                              width: imageSize,
                              height: imageSize,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: SizeConfig.screenHigh * 0.02),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.06,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'معلومات نمط الحياة',
                    style: AppStyles.almaraiBold(context).copyWith(
                      color: AppColors.kPrimaryColor1,
                      fontSize: getResponsiveFontSize(context, fontSize: 14),
                    ),
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.screenHigh * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LifestyleIcon(
                    image: AppImages.alcohol,
                    isSelected: isDrinker,
                    onTap: () {
                      setState(() {
                        isDrinker = !isDrinker;
                      });
                      context.read<ProfileInfoCubit>().setIsDrinker(isDrinker);
                    },
                  ),
                  SizedBox(width: SizeConfig.screenWidth * 0.045),
                  LifestyleIcon(
                    image: AppImages.emotionalState,
                    isSelected: isMarried,
                    onTap: () {
                      setState(() {
                        isMarried = !isMarried;
                      });
                      context.read<ProfileInfoCubit>().setIsMarried(isMarried);
                    },
                  ),
                  SizedBox(width: SizeConfig.screenWidth * 0.045),
                  LifestyleIcon(
                    image: AppImages.smoker,
                    isSelected: isSmoker,
                    onTap: () {
                      setState(() {
                        isSmoker = !isSmoker;
                      });
                      context.read<ProfileInfoCubit>().setIsSmoker(isSmoker);
                    },
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.screenHigh * 0.03),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.07,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: BlocConsumer<ProfileInfoCubit, ProfileInfoState>(
                        listener: (context, state) {
                          if (state.errorMessage != null) {
                            print('Error message: ${state.errorMessage}');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.errorMessage!),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                          if (state.isSuccess == true) {
                            context.pushNamed(
                              RouteNames.setLocation,

                              // RouteNames.upload,
                              extra: context.read<ProfileInfoCubit>(),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state.isSubmitting == true) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.kPrimaryColor1,
                              ),
                            );
                          }
                          return ProfileActionButton(
                            text: 'التالي',
                            onPressed: () {
                              context
                                  .read<ProfileInfoCubit>()
                                  .setMedicalHistory(chronicController.text);
                              context
                                  .read<ProfileInfoCubit>()
                                  .setSurgicalHistory(surgeryController.text);
                              context.read<ProfileInfoCubit>().setAllergies(
                                allergyController.text,
                              );
                              context.read<ProfileInfoCubit>().setMedicines(
                                medsController.text,
                              );
                              context.read<ProfileInfoCubit>().setBloodType(
                                selectedBloodType ?? '',
                              );
                              context.read<ProfileInfoCubit>().setIsDrinker(
                                isDrinker,
                              );
                              context.read<ProfileInfoCubit>().setIsMarried(
                                isMarried,
                              );

                              context.read<ProfileInfoCubit>().setIsSmoker(
                                isSmoker,
                              );

                              context.pushNamed(
                                RouteNames.setLocation,
                                extra: context.read<ProfileInfoCubit>(),
                              );
                            },
                            filled: true,
                            borderRadius: 25,
                            fontSize: getResponsiveFontSize(
                              context,
                              fontSize: 19,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: SizeConfig.screenWidth * 0.09),
                    Expanded(
                      child: ProfileActionButton(
                        text: 'عودة',
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        filled: false,
                        borderRadius: 25,
                        fontSize: getResponsiveFontSize(context, fontSize: 19),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.screenHigh * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
