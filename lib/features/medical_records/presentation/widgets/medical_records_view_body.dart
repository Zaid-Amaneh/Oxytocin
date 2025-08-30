import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/core/widgets/un_expected_error.dart';
import 'package:oxytocin/features/medical_records/presentation/viewmodels/patient_archives_cubit.dart';
import 'package:oxytocin/features/medical_records/presentation/viewmodels/patient_archives_state.dart';
import 'package:oxytocin/features/medical_records/presentation/widgets/medical_archive_card.dart';

class MedicalRecordsViewBody extends StatelessWidget {
  const MedicalRecordsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return CustomScrollView(
      slivers: [
        BlocBuilder<PatientArchivesCubit, PatientArchivesState>(
          builder: (context, state) {
            if (state is PatientArchivesLoading) {
              return SliverToBoxAdapter(
                child: Helper.buildShimmerBox(
                  width: width * 0.9,
                  height: height * 0.25,
                  count: 4,
                ),
              );
            } else if (state is PatientArchivesLoaded) {
              final list = state.archivesResponse.results;
              return SliverList.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final patientArchive = list[index];

                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: MedicalArchiveCard(
                      visitDate: patientArchive.appointment.visitDate,
                      visitTime: patientArchive.appointment.visitTime,
                      caseHistory: patientArchive.caseHistory,
                      mainComplaint: patientArchive.mainComplaint,
                      paid: patientArchive.paid,
                      cost: patientArchive.cost,
                      remaining: patientArchive.cost - patientArchive.paid,
                      vitalSigns: patientArchive.vitalSigns,
                      recommendations: patientArchive.recommendations,
                    ),
                  );
                },
              );
            } else {
              return const SliverToBoxAdapter(child: UnExpectedError());
            }
          },
        ),
      ],
    );
  }
}
