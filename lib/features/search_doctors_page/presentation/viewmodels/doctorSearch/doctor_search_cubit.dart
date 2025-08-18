import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/features/search_doctors_page/data/models/doctor_model.dart';
import 'package:oxytocin/features/search_doctors_page/data/models/doctor_search_request.dart';
import 'package:oxytocin/features/search_doctors_page/data/services/doctor_search_service.dart';
part 'doctor_search_state.dart';

class DoctorSearchCubit extends Cubit<DoctorSearchState> {
  final DoctorSearchService _doctorSearchService;

  DoctorSearchRequest _currentRequest = DoctorSearchRequest(
    useCurrentLocation: false,
  );

  DoctorSearchRequest get currentRequest => _currentRequest;

  DoctorSearchCubit(this._doctorSearchService) : super(DoctorSearchInitial());

  int _currentPage = 1;
  Future<void> typing() async {
    emit(DoctorSearchLoading());
    Logger().i("GGGD");
  }

  Future<void> searchDoctors({bool isNewSearch = false}) async {
    final currentState = state;
    List<DoctorModel> oldDoctors = [];
    if (isNewSearch) {
      _currentPage = 1;
      oldDoctors.clear();
      emit(DoctorSearchLoading());
    } else if (currentState is DoctorSearchSuccess) {
      oldDoctors = currentState.doctors;
    }
    dynamic finalRequest = _currentRequest.copyWith(page: _currentPage);
    Logger().f(_currentRequest.toQueryParams());
    try {
      final response = await _doctorSearchService.searchDoctors(finalRequest);
      final newDoctors = response.results;
      final hasReachedMax = response.next == null;
      emit(
        DoctorSearchSuccess(
          doctors: oldDoctors + newDoctors,
          hasReachedMax: hasReachedMax,
        ),
      );
      if (!hasReachedMax) {
        _currentPage++;
      }
    } catch (e) {
      Logger().e(e.toString());
      if (e is Failure) {
        emit(DoctorSearchFailure(e));
      } else {
        emit(const DoctorSearchFailure(UnknownFailure()));
      }
    }
  }

  void onTyping() {
    typing();
  }

  void updateAndSearch({
    bool? useCurrentLocation,
    String? query,
    int? specialties,
    String? gender,
    double? distance,
    double? latitude,
    double? longitude,
    String? unit,
    String? ordering,
  }) {
    _currentRequest = _currentRequest.copyWith(
      useCurrentLocation: useCurrentLocation,
      query: query,
      specialties: specialties,
      gender: gender,
      distance: distance,
      latitude: latitude,
      longitude: longitude,
      unit: unit,
      ordering: ordering,
      pageSize: 6,
    );
    searchDoctors(isNewSearch: true);
  }
}
