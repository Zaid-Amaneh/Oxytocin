import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:oxytocin/features/categories/presentation/cubit/categories_state.dart';

class DoctorsPage extends StatelessWidget {
  const DoctorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الأطباء")),
      body: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          if (state.status == CategoriesStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == CategoriesStatus.failure) {
            return Center(child: Text("خطأ: ${state.error}"));
          } else if (state.doctors.isEmpty) {
            return const Center(child: Text("لا يوجد أطباء"));
          }

          // مبدئياً اعرض الاسم + الاختصاص
          final doctors = state.doctors.first.results;
          return ListView.builder(
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              final d = doctors[index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(d.user.image),
                  ),
                  title: Text("${d.user.firstName} ${d.user.lastName}"),
                  subtitle: Text(d.mainSpecialty.specialty.nameAr),
                  trailing: Text("⭐ ${d.rate}"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
