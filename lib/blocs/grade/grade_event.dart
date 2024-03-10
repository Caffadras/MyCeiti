part of 'grade_bloc.dart';

@immutable
abstract class GradeEvent {}

class FetchGrade extends GradeEvent{
  final String studentId;

  FetchGrade({required this.studentId});
}