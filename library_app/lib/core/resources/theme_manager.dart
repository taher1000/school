import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      // main colors of the app
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.secondry,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.grey1,
      iconTheme: IconThemeData(
        color: ColorManager.darkGreyText,
      ),
      // ripple color
      splashColor: ColorManager.secondry,
      // will be used incase of disabled button for example

      // card view theme
      cardTheme: CardTheme(
          color: ColorManager.white,
          shadowColor: ColorManager.grey,
          elevation: AppSize.s4),
      // App bar theme
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: ColorManager.primary,
          elevation: AppSize.s4,
          shadowColor: ColorManager.grey,
          titleTextStyle: TextStyleManager.getRegularStyle(
              color: ColorManager.white, fontSize: FontSize.s16.sp)),
      // Button theme
      buttonTheme: ButtonThemeData(
          shape: const StadiumBorder(),
          disabledColor: ColorManager.grey1,
          buttonColor: ColorManager.primary,
          splashColor: ColorManager.grey),

      // elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, AppSize.s12),
              textStyle:
                  TextStyleManager.getRegularStyle(color: ColorManager.white),
              backgroundColor: Colors.transparent,
              elevation: 0,
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s0)))),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              minimumSize: Size(double.infinity, AppSize.s12),
              textStyle:
                  TextStyleManager.getRegularStyle(color: ColorManager.white),
              backgroundColor: Colors.transparent,
              elevation: 0,
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s0)))),
      // Text theme
      textTheme: TextTheme(
        displayLarge: TextStyleManager.getRegularStyle(
            color: ColorManager.white, fontSize: FontSize.s57.sp),
        displayMedium: TextStyleManager.getRegularStyle(
            color: ColorManager.white, fontSize: FontSize.s45.sp),
        displaySmall: TextStyleManager.getRegularStyle(
            color: ColorManager.white, fontSize: FontSize.s36.sp),
        //
        headlineLarge: TextStyleManager.getRegularStyle(
            color: ColorManager.white, fontSize: FontSize.s32.sp),
        headlineMedium: TextStyleManager.getMediumStyle(
            color: ColorManager.white, fontSize: FontSize.s28.sp),
        headlineSmall: TextStyleManager.getSemiBoldStyle(
            color: ColorManager.white, fontSize: FontSize.s24.sp),
        //
        titleLarge: TextStyleManager.getSemiBoldStyle(
            color: ColorManager.white, fontSize: FontSize.s20.sp),
        titleMedium: TextStyleManager.getSemiBoldStyle(
            color: ColorManager.greyTextColor, fontSize: FontSize.s18.sp),
        titleSmall: TextStyleManager.getRegularStyle(
            color: ColorManager.darkGrey, fontSize: FontSize.s14.sp),
        //
        labelLarge: TextStyleManager.getSemiBoldStyle(
            color: ColorManager.darkGreyText, fontSize: FontSize.s14.sp),
        labelMedium: TextStyleManager.getMediumStyle(
            color: ColorManager.white, fontSize: FontSize.s12.sp),
        labelSmall: TextStyleManager.getMediumStyle(
            color: ColorManager.white, fontSize: FontSize.s10.sp),
        //
        bodyLarge: TextStyleManager.getMediumStyle(
            color: ColorManager.white, fontSize: FontSize.s16.sp),
        bodyMedium: TextStyleManager.getMediumStyle(
            color: ColorManager.white, fontSize: FontSize.s14.sp),
        bodySmall: TextStyleManager.getRegularStyle(
            color: ColorManager.white, fontSize: FontSize.s12.sp),
      ),
      // input decoration theme (text form field)

      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        // hint style
        hintStyle: TextStyleManager.getRegularStyle(color: ColorManager.black),

        // label style
        labelStyle: TextStyleManager.getMediumStyle(
            color: ColorManager.black, fontSize: FontSize.s22.sp),
        // error style
        errorStyle: TextStyleManager.getRegularStyle(color: ColorManager.error),

        // enabled border

        // error border
        errorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.error, width: AppSize.s1),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
        // focused error border
        focusedErrorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.primary, width: AppSize.s1),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
      ));
}
