import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/features/manage_medical_records/data/models/specialty_access_model.dart';
import 'package:oxytocin/features/manage_medical_records/data/services/specialty_access_service.dart';
import 'package:oxytocin/features/manage_medical_records/presentation/viewmodels/specialty_access_state.dart';

class SpecialtyAccessCubit extends Cubit<SpecialtyAccessState> {
  final SpecialtyAccessService _specialtyAccessService;

  SpecialtyAccessCubit(this._specialtyAccessService)
    : super(SpecialtyAccessInitial());

  Future<void> fetchSpecialtyAccessList() async {
    emit(SpecialtyAccessLoading());
    try {
      final specialties = await _specialtyAccessService
          .getSpecialtyAccessList();
      emit(SpecialtyAccessLoaded(specialties));
    } on Failure catch (e) {
      emit(SpecialtyAccessError(e.toString()));
    } catch (e) {
      emit(
        SpecialtyAccessError("An unexpected error occurred: ${e.toString()}"),
      );
    }
  }

  Future<void> updateSpecialtyVisibility({
    required int specialtyAccessId,
    required String newVisibility,
  }) async {
    final currentState = state;
    if (currentState is! SpecialtyAccessLoaded) return;

    final originalList = List<SpecialtyAccess>.from(currentState.specialties);
    final itemIndex = originalList.indexWhere(
      (item) => item.id == specialtyAccessId,
    );

    if (itemIndex == -1) return;
    final updatedItem = originalList[itemIndex].copyWith(
      visibility: newVisibility,
    );
    final optimisticList = List<SpecialtyAccess>.from(originalList)
      ..[itemIndex] = updatedItem;

    emit(SpecialtyAccessUpdating(optimisticList, specialtyAccessId));

    try {
      final confirmedItem = await _specialtyAccessService
          .updateSpecialtyVisibility(
            specialtyAccessId: specialtyAccessId,
            visibility: newVisibility,
          );

      final finalList = List<SpecialtyAccess>.from(optimisticList)
        ..[itemIndex] = confirmedItem;
      emit(SpecialtyAccessLoaded(finalList));
    } catch (e) {
      emit(SpecialtyAccessLoaded(originalList));
      emit(
        SpecialtyAccessError(
          e is Failure ? e.toString() : "Failed to update: ${e.toString()}",
        ),
      );
    }
  }
}
