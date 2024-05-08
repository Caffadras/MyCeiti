part of 'schedule_bloc.dart';

@immutable
abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}


class ScheduleLoading extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  final WeekScheduleModel schedule;

  ScheduleLoaded({required this.schedule});
}

class ScheduleError extends ScheduleState {
}

class ScheduleTimeout extends ScheduleState {
}