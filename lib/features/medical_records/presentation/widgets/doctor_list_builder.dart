import 'package:flutter/material.dart';
import 'package:oxytocin/features/search_doctors_page/data/models/doctor_model.dart';
import 'package:oxytocin/features/search_doctors_page/data/models/main_specialty_model.dart';
import 'package:oxytocin/features/search_doctors_page/data/models/specialty_model.dart';
import 'package:oxytocin/features/search_doctors_page/data/models/user_model.dart';
import 'package:oxytocin/features/search_doctors_page/presentation/widget/doctor_card.dart';

class DoctorListBuilder extends StatelessWidget {
  const DoctorListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(6.0),
          child: DoctorCard(
            doctorModel: DoctorModel(
              user: UserModel(
                id: 1,
                firstName: 'firstName',
                lastName: 'lastName',
                image: 'image',
              ),
              mainSpecialty: MainSpecialtyModel(
                specialty: SpecialtyModel(
                  id: 2,
                  nameEn: 'nameEn',
                  nameAr: 'nameAr',
                ),
                university: 'university',
              ),
              rate: 15,
              rates: 15,
            ),
            spec: true,
          ),
        );
      },
    );
  }
}
