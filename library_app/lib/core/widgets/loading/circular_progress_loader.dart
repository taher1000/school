import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/core/resources/color_manager.dart';
import 'package:library_app/core/resources/values_manager.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: AppPadding.p4.h),
        child: Center(
          child: SizedBox(
            height: 30.h,
            width: 30.w,
            child: CircularProgressIndicator(
              color: ColorManager.darkPrimary,
            ),
          ),
        ));
  }
}
