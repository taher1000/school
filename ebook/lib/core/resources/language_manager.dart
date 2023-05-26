import 'package:flutter/material.dart';

enum LanguageType { english, arabic }

abstract class LanguageManager {
  static const String arabic = "ar";
  static const String english = "en";
  static const String assetsPathLocal = "assets/language";
  static const Locale arabicLocal = Locale("ar", "SA");
  static const Locale englishLocal = Locale("en", "US");
}

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.english:
        return LanguageManager.english;
      case LanguageType.arabic:
        return LanguageManager.arabic;
    }
  }
}
