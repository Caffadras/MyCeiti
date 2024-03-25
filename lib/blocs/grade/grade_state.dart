part of 'grade_bloc.dart';

@immutable
abstract class GradeState {}

class GradeInitial extends GradeState {}

class GradeLoading extends GradeState {}

class GradeLoaded extends GradeState {
  final List<SubjectGrades> response;

  GradeLoaded({required this.response});
}

class GradeError extends GradeState {
  final String error;

  GradeError({required this.error});
}