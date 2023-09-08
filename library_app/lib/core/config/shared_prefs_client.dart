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

  // get englishFullName
  String get englishFullName =>
      prefs.getString(SharedPreferencesKeys.kUserEnglishFullNameKey) ?? "";
  // set englishFullName
  set englishFullName(String? englishFullName) => prefs.setString(
      SharedPreferencesKeys.kUserEnglishFullNameKey, englishFullName!);
  // get email
  String get arabicFullName =>
      prefs.getString(SharedPreferencesKeys.kUserArabicFullNameKey) ?? "";
  // set arabicFullName
  set arabicFullName(String? arabicFullName) => prefs.setString(
      SharedPreferencesKeys.kUserArabicFullNameKey, arabicFullName!);

  // save user token
  set accessToken(String? userToken) =>
      prefs.setString(SharedPreferencesKeys.kUserAccessTokenKey, userToken!);

  // set username
  set userName(String? userName) =>
      prefs.setString(SharedPreferencesKeys.kUserNameKey, userName!);
  // get username
  String get userName =>
      prefs.getString(SharedPreferencesKeys.kUserNameKey) ?? "";

  // set user type
  set userRole(int? userRole) =>
      prefs.setInt(SharedPreferencesKeys.kUserRoleKey, userRole!);
  // get user type
  int get userRole => prefs.getInt(SharedPreferencesKeys.kUserRoleKey) ?? 0;

  // set user image
  set userImage(String? userImage) =>
      prefs.setString(SharedPreferencesKeys.kUserImageKey, userImage!);
  // get user image
  String get userImage =>
      prefs.getString(SharedPreferencesKeys.kUserImageKey) ?? "";

  // get user token

  String get accessToken =>
      prefs.getString(SharedPreferencesKeys.kUserAccessTokenKey) ?? "";
  // save user refresh token
  set refreshToken(String? userToken) =>
      prefs.setString(SharedPreferencesKeys.kRefreshTokenKey, userToken!);

  String get refreshToken =>
      prefs.getString(SharedPreferencesKeys.kRefreshTokenKey) ?? "";

// save user refresh token
  set setFirstTimeLogin(bool? firstTimeLogin) =>
      prefs.setBool(SharedPreferencesKeys.kFirstTimeLogin, firstTimeLogin!);

  bool get firstTimeLogin =>
      prefs.getBool(SharedPreferencesKeys.kFirstTimeLogin) ?? true;

  // set a string in prefs
  void setString(String key, String data) async =>
      await prefs.setString(key, data);

  String? getString(String key) => prefs.getString(key);

  clearUserData() async {
    await prefs.remove(SharedPreferencesKeys.kRefreshTokenKey);
    await prefs.remove(SharedPreferencesKeys.kUserAccessTokenKey);
    await prefs.remove(SharedPreferencesKeys.kUserArabicFullNameKey);
    await prefs.remove(SharedPreferencesKeys.kUserEnglishFullNameKey);
    await prefs.remove(SharedPreferencesKeys.kUserEmailKey);
    await prefs.remove(SharedPreferencesKeys.kSelectedLanguageKey);
    await prefs.remove(SharedPreferencesKeys.kUserImageKey);
    await prefs.remove(SharedPreferencesKeys.kUserNameKey);
    await prefs.remove(SharedPreferencesKeys.kUserRoleKey);
  }
}
