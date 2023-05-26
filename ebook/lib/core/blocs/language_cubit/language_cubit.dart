import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:ebook/core/resources/shared_prefs_keys.dart';
import 'package:flutter/material.dart';

import '../../../injection_container.dart';
import '../../config/shared_prefs_client.dart';
part 'language_state.dart';

final String defaultLocale = Platform.localeName;

class LanguageCubit extends Cubit<LanguageState> {
  static Locale? _locale = cachedLanguage == null
      ? defaultLocale.substring(0, 2) == 'ar'
          ? const Locale('ar', '')
          : const Locale('en', '')
      : Locale(cachedLanguage!, '');

  static String get currentLanguage => _locale!.toString();

  static final SharedPrefsClient sharedPrefsClient = getIt();

  static String? get cachedLanguage =>
      sharedPrefsClient.getString(SharedPreferencesKeys.kSelectedLanguageKey);

  LanguageCubit()
      : super(
          SelectedLocale(
            cachedLanguage == null ? _locale! : Locale(cachedLanguage!, ''),
          ),
        ) {
    if (cachedLanguage == null) {
      sharedPrefsClient.setString(
        SharedPreferencesKeys.kSelectedLanguageKey,
        defaultLocale.substring(0, 2),
      );
    }

    debugPrint("DEFAULT-lANG ${defaultLocale.substring(0, 2)}");
    debugPrint("DEFAULT-lANG $cachedLanguage");
  }

  void toArabic() {
    sharedPrefsClient.setString(
        SharedPreferencesKeys.kSelectedLanguageKey, 'ar');
    emit(SelectedLocale(_locale = const Locale('ar', '')));
  }

  void toEnglish() {
    sharedPrefsClient.setString(
        SharedPreferencesKeys.kSelectedLanguageKey, 'en');
    emit(SelectedLocale(_locale = const Locale('en', '')));
  }

  static bool get isArabic => currentLanguage == 'ar';

  static bool get isEnglish => currentLanguage == 'en';
}
