import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/color_manager.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingPageWidget extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;
  const OnboardingPageWidget(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: SvgPicture.asset(
              image,
              height: 300.0.h,
              width: 300.0.w,
            ),
          ),
          SizedBox(height: 30.0.h),
          Text(
            title,
            style: TextStyleManager.getSemiBoldStyle(
                fontSize: FontSize.s20.sp, color: ColorManager.darkPrimary),
          ),
          SizedBox(height: 15.0.h),
          Text(
            subTitle,
            style: TextStyleManager.getLightStyle(
                fontSize: FontSize.s12.sp, color: ColorManager.black),
          ),
        ],
      ),
    );
  }
}
