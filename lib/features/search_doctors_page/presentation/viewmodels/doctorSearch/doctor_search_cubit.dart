import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:oxytocin/core/errors/failure.dart';
import 'package:oxytocin/features/search_doctors_page/data/models/doctor_model.dart';
import 'package:oxytocin/features/search_doctors_page/data/models/doctor_search_request.dart';
import 'package:oxytocin/features/search_doctors_page/data/services/doctor_search_service.dart';

part 'doctor_search_state.dart';

// class DoctorSearchCubit extends Cubit<DoctorSearchState> {
//   final DoctorSearchService _doctorSearchService;

//   DoctorSearchCubit(this._doctorSearchService) : super(DoctorSearchInitial());

//   int _currentPage = 1;

//   Future<void> searchDoctors({DoctorSearchRequest? request}) async {
//     Logger().f(request!.query ?? "dsfkjuhfdkhfdk");

//     final currentState = state;
//     List<DoctorModel> oldDoctors = [];

//     if (currentState is DoctorSearchSuccess) {
//       oldDoctors = currentState.doctors;
//     }

//     _currentPage = 1;
//     emit(DoctorSearchLoading());

//     final finalRequest = (request ?? DoctorSearchRequest()).copyWith(
//       page: _currentPage,
//     );

//     try {
//       final response = await _doctorSearchService.searchDoctors(finalRequest);
//       final newDoctors = response.results;
//       final hasReachedMax = response.next == null;

//       emit(
//         DoctorSearchSuccess(
//           doctors: (request != null) ? newDoctors : (oldDoctors + newDoctors),
//           hasReachedMax: hasReachedMax,
//         ),
//       );
//     } catch (e) {
//       if (e is Failure) {
//         emit(DoctorSearchFailure(e));
//       } else {
//         emit(const DoctorSearchFailure(UnknownFailure()));
//       }
//     }
//   }
// }

class DoctorSearchCubit extends Cubit<DoctorSearchState> {
  final DoctorSearchService _doctorSearchService;

  DoctorSearchRequest _currentRequest = DoctorSearchRequest();

  DoctorSearchRequest get currentRequest => _currentRequest;

  DoctorSearchCubit(this._doctorSearchService) : super(DoctorSearchInitial());

  int _currentPage = 1;

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

    final finalRequest = _currentRequest.copyWith(page: _currentPage);
    Logger().f("Executing search with params: ${finalRequest.toQueryParams()}");

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
      if (e is Failure) {
        emit(DoctorSearchFailure(e));
      } else {
        emit(const DoctorSearchFailure(UnknownFailure()));
      }
    }
  }

  void updateAndSearch({
    String? query,
    int? specialties,
    String? gender,
    double? distance,
    double? latitude,
    double? longitude,
    String? ordering,
  }) {
    _currentRequest = _currentRequest.copyWith(
      query: query,
      specialties: specialties,
      gender: gender,
      distance: distance,
      latitude: latitude,
      longitude: longitude,
      ordering: ordering,
    );

    searchDoctors(isNewSearch: true);
  }
}
