import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/routing/navigation_service.dart';
import 'package:oxytocin/core/routing/route_names.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/core/widgets/un_expected_error.dart';
import 'package:oxytocin/features/medical_records/presentation/viewmodels/doctors_cubit.dart';
import 'package:oxytocin/features/medical_records/presentation/viewmodels/doctors_state.dart';
import 'package:oxytocin/features/search_doctors_page/data/models/doctor_model.dart';
import 'package:oxytocin/features/search_doctors_page/data/models/main_specialty_model.dart';
import 'package:oxytocin/features/search_doctors_page/data/models/specialty_model.dart';
import 'package:oxytocin/features/search_doctors_page/data/models/user_model.dart';
import 'package:oxytocin/features/search_doctors_page/presentation/widget/doctor_card.dart';

class DoctorListBuilder extends StatelessWidget {
  const DoctorListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return BlocBuilder<DoctorsCubit, DoctorsState>(
      builder: (context, state) {
        if (state is DoctorsLoading) {
          return SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Helper.buildShimmerBox(
                  width: width * 0.4,
                  height: width * 0.4,
                  count: 3,
                ),
                Helper.buildShimmerBox(
                  width: width * 0.4,
                  height: width * 0.4,
                  count: 3,
                ),
              ],
            ),
          );
        } else if (state is DoctorsLoaded) {
          final list = state.doctorsResponse.results;
          if (list.isEmpty) {
            return SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  spacing: 16,
                  children: [
                    SizedBox(height: height * 0.07),
                    Image.asset(
                      AppImages.comfortablePerson,
                      height: height * 0.35,
                    ),
                    Text(
                      context.tr.noMedicalRecordsInThisField,
                      style: AppStyles.almaraiBold(
                        context,
                      ).copyWith(color: AppColors.textSecondary, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: DoctorCard(
                    doctorModel: DoctorModel(
                      user: UserModel(
                        id: list[index].user.id,
                        firstName: list[index].user.firstName,
                        lastName: list[index].user.lastName,
                        image: list[index].user.image ?? "",
                      ),
                      mainSpecialty: MainSpecialtyModel(
                        specialty: SpecialtyModel(
                          id: list[index].mainSpecialty.specialty.id,
                          nameEn: list[index].mainSpecialty.specialty.nameEn,
                          nameAr: list[index].mainSpecialty.specialty.nameAr,
                        ),
                        university: list[index].mainSpecialty.university,
                      ),
                      rate: list[index].appointmentsCount.toDouble(),
                      rates: list[index].appointmentsCount,
                    ),
                    spec: true,
                    onTap: () {
                      NavigationService().pushToNamedWithParams(
                        RouteNames.medicalRecordsView,
                        extra: {
                          'id': list[index].user.id,
                          'name':
                              '${list[index].user.firstName} ${list[index].user.lastName}',
                        },
                      );
                    },
                  ),
                );
              },
            );
          }
        } else {
          return const SliverToBoxAdapter(child: UnExpectedError());
        }
      },
    );
  }
}
