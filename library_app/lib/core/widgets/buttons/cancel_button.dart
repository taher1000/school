import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/app_localization.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';

class CancelButton extends StatelessWidget {
  final String? text;

  final VoidCallback onPressed;
  const CancelButton(
      {super.key, required this.onPressed, this.text = "cancel"});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(50.h, 50.w),
        maximumSize: Size(50.h, 50.w),
        backgroundColor: ColorManager.error,
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
