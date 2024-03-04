part of 'theme_bloc.dart';

@immutable
abstract class ThemeState {}

class ThemeInitial extends ThemeState {}

class ThemeLoaded extends ThemeState {
  final ThemeData themeData;

  ThemeLoaded({required this.themeData});
}
