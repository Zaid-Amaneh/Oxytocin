import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/core/Utils/services/local_storage_service.dart';
import 'package:oxytocin/core/routing/navigation_service.dart';
import 'package:oxytocin/core/routing/route_names.dart';
import 'package:oxytocin/features/categories/data/datasources/categories_remote_data_source.dart';
import 'package:oxytocin/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:oxytocin/features/categories/presentation/cubit/categories_state.dart';

class DoctorsPage extends StatelessWidget {
  final int id;
  const DoctorsPage({super.key, required this.id});

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: const Text("الأطباء")),
  //     body: BlocBuilder<CategoriesCubit, CategoriesState>(
  //       builder: (context, state) {
  //         if (state.status == CategoriesStatus.loading) {
  //           return const Center(child: CircularProgressIndicator());
  //         } else if (state.status == CategoriesStatus.failure) {
  //           return Center(child: Text("خطأ: ${state.error}"));
  //         } else if (state.doctors.isEmpty) {
  //           return const Center(child: Text("لا يوجد أطباء"));
  //         }

  //         final doctors = state.doctors;
  //         return ListView.builder(
  //           itemCount: doctors.length,
  //           itemBuilder: (context, index) {
  //             final d = doctors[index];
  //             return Card(
  //               child: ListTile(
  //                 leading: CircleAvatar(
  //                   backgroundImage: NetworkImage(d.user.image),
  //                 ),
  //                 title: Text("${d.user.firstName} ${d.user.lastName}"),
  //                 subtitle: Text(d.mainSpecialty.specialty.nameAr),
  //                 trailing: Text("⭐ ${d.rate}"),
  //               ),
  //             );
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }

  // في DoctorsPage
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الأطباء")),
      body: BlocProvider(
        create: (_) =>
            CategoriesCubit(CategoriesRemoteDataSource(), LocalStorageService())
              ..loadDoctorsBySubspecialty(id),
        child: BlocConsumer<CategoriesCubit, CategoriesState>(
          listener: (context, state) {
            if (state.status == CategoriesStatus.failure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("خطأ: ${state.error}")));
            }
          },
          builder: (context, state) {
            if (state.status == CategoriesStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == CategoriesStatus.failure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("خطأ: ${state.error}"),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<CategoriesCubit>().fetchCategories(),
                      child: Text("إعادة المحاولة"),
                    ),
                  ],
                ),
              );
            } else if (state.doctors.isEmpty) {
              return const Center(child: Text("لا يوجد أطباء في هذا الاختصاص"));
            }

            final doctors = state.doctors;
            return ListView.builder(
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                final doctor = doctors[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(doctor.user.image),
                    ),
                    title: Text(
                      "${doctor.user.firstName} ${doctor.user.lastName}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(doctor.mainSpecialty.specialty.nameAr),
                        Text(doctor.address),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("⭐ ${doctor.rate}"),
                        Text("(${doctor.rates} تقييم)"),
                      ],
                    ),
                    onTap: () {
                      NavigationService().pushToNamedWithParams(
                        RouteNames.doctorProfileView,

                        queryParams: {'id': doctor.user.id.toString()},
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
