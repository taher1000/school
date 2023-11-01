import 'package:flutter/material.dart';

abstract class ColorManager {
  static Color primary = HexColor.fromHex("#FFB84C");
  static Color darkPrimary = HexColor.fromHex("#F16767");
  static Color secondry = HexColor.fromHex("#FDD36A");
  static Color secondryLight = HexColor.fromHex("#F5EAEA");
  static Color darkGrey = HexColor.fromHex("#313131");
  static Color grey = HexColor.fromHex("#B0B0B0");
  // new colors
  static Color grey1 = HexColor.fromHex("#707070");
  static Color greyDark = HexColor.fromHex("#797979");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color error = HexColor.fromHex("#e61f34");
  static Color green = HexColor.fromHex("#26CE55");
  static Color black = HexColor.fromHex("#000000"); // red color

  // text colors
  static Color greyTextColor = HexColor.fromHex("#FACBBD");
  static Color darkGreyText = HexColor.fromHex("#A5A5A5");
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString"; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
