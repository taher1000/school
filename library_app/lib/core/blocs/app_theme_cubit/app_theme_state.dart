part of 'app_theme_cubit.dart';

abstract class AppThemeState extends Equatable {
  const AppThemeState(this.themeMode);
  final ThemeMode themeMode;
  @override
  List<Object> get props => [themeMode];
}

class AppThemeInitial extends AppThemeState {
  AppThemeInitial() : super(sharedPrefsClient.theme!);
}

class SelectedTheme extends AppThemeState {
  final ThemeMode theme;
  const SelectedTheme(this.theme) : super(theme);
  @override
  List<Object> get props => [theme.index];
}
