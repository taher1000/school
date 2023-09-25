import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/core/resources/app_localization.dart';
import 'package:library_app/core/resources/font_manager.dart';
import 'package:library_app/core/resources/styles_manager.dart';

import '../../resources/color_manager.dart';

class OKButton extends StatelessWidget {
  final String? text;

  final VoidCallback onPressed;
  const OKButton({super.key, required this.onPressed, this.text = "ok"});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(30.h, 50.w),
        maximumSize: Size(30.h, 50.w),
        backgroundColor: ColorManager.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        AppLocalization.of(context).getTranslatedValues(text!),
        style: TextStyleManager.getSemiBoldStyle(
          color: ColorManager.white,
          fontSize: FontSize.s18.sp,
        ),
      ),
    );
  }
}
