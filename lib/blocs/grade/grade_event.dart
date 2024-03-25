part of 'grade_bloc.dart';

@immutable
abstract class GradeEvent {}

class FetchGrade extends GradeEvent{
  final String idnp;

  FetchGrade({required this.idnp});
}