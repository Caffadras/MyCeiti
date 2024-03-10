part of 'schedule_bloc.dart';

@immutable
abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}


class ScheduleLoading extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  final String response;

  ScheduleLoaded({required this.response});
}

class ScheduleError extends ScheduleState {
  final String error;

  ScheduleError({required this.error});
}