import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oxytocin/features/doctor_profile.dart/data/services/favorites_service.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesService _favoritesService;

  FavoritesCubit(this._favoritesService) : super(FavoritesInitial());

  Future<void> addDoctorToFavorites(int doctorId) async {
    emit(FavoritesLoading());
    try {
      await _favoritesService.addDoctorToFavorites(doctorId: doctorId);
      emit(const FavoritesAddSuccess());
    } catch (e) {
      emit(FavoritesFailure(errorMessage: e.toString()));
    }
  }

  Future<void> removeDoctorFromFavorites(int doctorId) async {
    emit(FavoritesLoading());
    try {
      await _favoritesService.deleteDoctorFromFavorites(doctorId: doctorId);
      emit(const FavoritesRemoveSuccess());
    } catch (e) {
      emit(FavoritesFailure(errorMessage: e.toString()));
    }
  }
}
