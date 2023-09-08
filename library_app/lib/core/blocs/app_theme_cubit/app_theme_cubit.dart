import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../injection_container.dart';

part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit() : super(AppThemeInitial());
  changeTheme(ThemeMode mode) {
    sharedPrefsClient.changeThemeToDark = mode == ThemeMode.dark;
    emit(SelectedTheme(mode));
  }
}
