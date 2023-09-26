import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/core/blocs/app_theme_cubit/app_theme_cubit.dart';
import 'package:library_app/core/resources/app_localization.dart';
import 'package:library_app/core/resources/font_manager.dart';
import 'package:library_app/injection_container.dart';

import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';

void showSnackBar(BuildContext context,
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

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
