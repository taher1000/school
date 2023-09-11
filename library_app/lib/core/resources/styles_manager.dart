import 'package:flutter/material.dart';

import 'font_manager.dart';

abstract class TextStyleManager {
  static TextStyle _getTextStyle(
      double fontSize, FontWeight fontWeight, Color color) {
    return TextStyle(
        overflow: TextOverflow.ellipsis,
        fontSize: fontSize,
        // fontFamily: fontFamily,
        color: color,
        fontWeight: fontWeight);
  }

// regular style

  static TextStyle getRegularStyle(
      {double fontSize = FontSize.s12, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.regular, color);
  }
// light text style

  static TextStyle getLightStyle(
      {double fontSize = FontSize.s12, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.light, color);
  }
// bold text style

  static TextStyle getBoldStyle(
      {double fontSize = FontSize.s12, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.bold, color);
  }

  static TextStyle getBlackStyle(
      {double fontSize = FontSize.s36, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.black, color);
  }

// semi bold text style

  static TextStyle getSemiBoldStyle(
      {double fontSize = FontSize.s12, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
  }

// medium text style

  static TextStyle getMediumStyle(
      {double fontSize = FontSize.s12, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.medium, color);
  }
}
