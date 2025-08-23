import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/core/Utils/app_images.dart';
import 'package:oxytocin/core/Utils/app_styles.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/routing/navigation_service.dart';
import 'package:oxytocin/core/routing/route_names.dart';
import 'package:oxytocin/core/theme/app_colors.dart';
import 'package:oxytocin/features/search_doctors_page/presentation/viewmodels/doctorSearch/doctor_search_cubit.dart';
import 'package:oxytocin/features/search_doctors_page/presentation/widget/doctor_card.dart';
import 'package:shimmer/shimmer.dart';

class AllDoctorsList extends StatefulWidget {
  final ScrollController scrollController;
  const AllDoctorsList({super.key, required this.scrollController});

  @override
  State<AllDoctorsList> createState() => _AllDoctorsListState();
}

class _AllDoctorsListState extends State<AllDoctorsList> {
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (widget.scrollController.position.pixels >=
        widget.scrollController.position.maxScrollExtent) {
      final state = context.read<DoctorSearchCubit>().state;
      if (state is DoctorSearchSuccess && !state.hasReachedMax) {
        context.read<DoctorSearchCubit>().searchDoctors(isNewSearch: false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorSearchCubit, DoctorSearchState>(
      builder: (context, state) {
        if (state is DoctorSearchSuccess) {
          if (state.doctors.isEmpty) {
            return SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(36, 36, 36, 8),
                    child: Image.asset(AppImages.searchNotFound),
                  ),
                  Text(
                    context.tr.no_doctor_found,
                    textAlign: TextAlign.center,
                    style: AppStyles.almaraiBold(
                      context,
                    ).copyWith(color: AppColors.kPrimaryColor1, fontSize: 14),
                  ),
                ],
              ),
            );
          }
          return SliverMainAxisGroup(
            slivers: [
              SliverGrid.builder(
                itemCount: state.doctors.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(6),
                    child: DoctorCard(
                      doctorModel: state.doctors[index],
                      onTap: () {
                        NavigationService().pushToNamedWithParams(
                          RouteNames.doctorProfileView,
                          queryParams: {
                            'id': state.doctors[index].user.id.toString(),
                          },
                        );
                      },
                    ),
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
              ),
              if (!state.hasReachedMax)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
            ],
          );
        } else if (state is DoctorSearchLoading) {
          return SliverToBoxAdapter(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        } else if (state is DoctorSearchFailure) {
          return SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(36, 36, 36, 8),
                  child: Image.asset(AppImages.unexpectedError),
                ),
                Text(
                  context.tr.server_error,
                  textAlign: TextAlign.center,
                  style: AppStyles.almaraiBold(
                    context,
                  ).copyWith(color: AppColors.kPrimaryColor1, fontSize: 14),
                ),
              ],
            ),
          );
        } else {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }
      },
    );
  }
}
