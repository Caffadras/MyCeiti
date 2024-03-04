part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class InitialThemeSetEvent extends ThemeEvent {}

class LoadTheme extends ThemeEvent{}

class UpdateTheme extends ThemeEvent{
  final String themePreference;

  UpdateTheme({required this.themePreference});
}