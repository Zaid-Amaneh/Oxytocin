import 'package:equatable/equatable.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesAddSuccess extends FavoritesState {
  final String successMessage;

  const FavoritesAddSuccess({
    this.successMessage = 'Added to favorites successfully!',
  });

  @override
  List<Object> get props => [successMessage];
}

class FavoritesRemoveSuccess extends FavoritesState {
  final String successMessage;

  const FavoritesRemoveSuccess({
    this.successMessage = 'Removed from favorites successfully!',
  });

  @override
  List<Object> get props => [successMessage];
}

class FavoritesFailure extends FavoritesState {
  final String errorMessage;

  const FavoritesFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
