import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../resources/shared_prefs_keys.dart';

class SharedPrefsClient {
  final SharedPreferences prefs;
  SharedPrefsClient(this.prefs);

  set changeThemeToDark(bool dark) {
    prefs.setString(
        SharedPreferencesKeys.kSelectedThemeKey, dark ? "dark" : "light");
  }

  ThemeMode? get theme {
    return prefs.getString(SharedPreferencesKeys.kSelectedThemeKey) == null
        ? ThemeMode.system
        : prefs.getString(SharedPreferencesKeys.kSelectedThemeKey) == "dark"
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  // app language
  String get currentLanguage =>
      prefs.getString(SharedPreferencesKeys.kSelectedLanguageKey) ?? "ar";

  bool? get enableNotification =>
      prefs.getBool(SharedPreferencesKeys.kEnableNotificationKey);

  set enableNotification(bool? value) {
    prefs.setBool(SharedPreferencesKeys.kEnableNotificationKey, value!);
  }

  // set email
  set email(String? email) =>
      prefs.setString(SharedPreferencesKeys.kUserEmailKey, email!);

  // get email
  String get email =>
      prefs.getString(SharedPreferencesKeys.kUserEmailKey) ?? "";

  // save user token
  set accessToken(String? userToken) =>
      prefs.setString(SharedPreferencesKeys.kUserAccessTokenKey, userToken!);

  // get user token

  String get accessToken =>
      prefs.getString(SharedPreferencesKeys.kUserAccessTokenKey) ?? "";

  // set a string in prefs
  void setString(String key, String data) async =>
      await prefs.setString(key, data);

  String? getString(String key) => prefs.getString(key);

  clearUserData() async {}
}
