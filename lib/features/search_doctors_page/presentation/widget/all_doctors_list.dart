import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
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
    // final size = MediaQuery.of(context).size;
    // final width = size.width;
    // final height = size.height;

    return BlocBuilder<DoctorSearchCubit, DoctorSearchState>(
      builder: (context, state) {
        if (state is DoctorSearchSuccess) {
          if (state.doctors.isEmpty) {
            return const SliverToBoxAdapter(
              child: Center(child: Text("لا يوجد أطباء بهذه المواصفات")),
            );
          }
          return SliverMainAxisGroup(
            slivers: [
              SliverGrid.builder(
                itemCount: state.doctors.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(6),
                    child: DoctorCard(doctorModel: state.doctors[index]),
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
          Logger().e(state.error.toString());
          return SliverToBoxAdapter(
            child: Center(child: Text("حدث خطأ ما: ${state.error}")),
          );
        } else {
          // الحالة الأولية (Initial)
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }
      },
    );
  }
}
//import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:logger/logger.dart';
// import 'package:oxytocin/features/search_doctors_page/presentation/viewmodels/doctorSearch/doctor_search_cubit.dart';
// import 'package:oxytocin/features/search_doctors_page/presentation/widget/doctor_card.dart';
// import 'package:shimmer/shimmer.dart';

// class AllDoctorsList extends StatelessWidget {
//   const AllDoctorsList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.sizeOf(context);
//     final width = size.width;
//     final height = size.height;
//     return BlocBuilder<DoctorSearchCubit, DoctorSearchState>(
//       builder: (context, state) {
//         if (state is DoctorSearchSuccess) {
//           return SliverGrid.builder(
//             itemCount: state.doctors.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.all(6),
//                 child: DoctorCard(doctorModel: state.doctors[index]),
//               );
//             },
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//             ),
//           );
//         } else if (state is DoctorSearchLoading) {
//           return SliverToBoxAdapter(
//             child: Shimmer.fromColors(
//               baseColor: Colors.grey[300]!,
//               highlightColor: Colors.grey[100]!,
//               child: SizedBox(
//                 width: width,
//                 height: height,
//                 child: GridView.builder(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                   ),
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.all(6.0),
//                       child: Card(
//                         elevation: 8,
//                         shape: RoundedRectangleBorder(
//                           side: const BorderSide(
//                             width: 1,
//                             color: Color(0xFFD9D9D9),
//                           ),
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           );
//         } else if (state is DoctorSearchFailure) {
//           Logger().e(state.error.translationKey);
//           return SliverToBoxAdapter(
//             child: Container(width: 50, height: 50, color: Colors.red),
//           );
//         } else {
//           return SliverToBoxAdapter(
//             child: Container(width: 50, height: 50, color: Colors.limeAccent),
//           );
//         }
//       },
//     );
//   }
// }
