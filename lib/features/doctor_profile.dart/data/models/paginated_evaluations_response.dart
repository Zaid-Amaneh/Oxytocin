import 'package:equatable/equatable.dart';

class PaginatedEvaluationsResponse extends Equatable {
  final int count;
  final String? next;
  final String? previous;
  final List<EvaluationModel> results;

  const PaginatedEvaluationsResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory PaginatedEvaluationsResponse.fromJson(Map<String, dynamic> json) {
    return PaginatedEvaluationsResponse(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: List<EvaluationModel>.from(
        json['results'].map((x) => EvaluationModel.fromJson(x)),
      ),
    );
  }

  @override
  List<Object?> get props => [count, next, previous, results];
}

class EvaluationModel extends Equatable {
  final String patientFirstName;
  final String patientLastName;
  final int rate;
  final String comment;

  const EvaluationModel({
    required this.patientFirstName,
    required this.patientLastName,
    required this.rate,
    required this.comment,
  });

  factory EvaluationModel.fromJson(Map<String, dynamic> json) {
    return EvaluationModel(
      patientFirstName: json['patient']['user']['first_name'],
      patientLastName: json['patient']['user']['last_name'],
      rate: json['rate'],
      comment: json['comment'],
    );
  }

  String get patientFullName => '$patientFirstName $patientLastName';

  @override
  List<Object?> get props => [patientFirstName, patientLastName, rate, comment];
}
