import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../resources/app_localization.dart';
import '../../resources/font_manager.dart';
import '../../../injection_container.dart';

import '../../resources/color_manager.dart';

void showCustomSnackBar(BuildContext context,
    {required String message, Color? backgroundColor, ThemeMode? themeMode}) {
  final snackBar = SnackBar(
    backgroundColor: backgroundColor ??
        (sharedPrefsClient.theme == ThemeMode.light
            ? ColorManager.darkPrimary
            : ColorManager.black),
    content: Text(AppLocalization.of(context).getTranslatedValues(message),
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: ColorManager.white,
              fontSize: FontSize.s14.sp,
            )),
  );
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
