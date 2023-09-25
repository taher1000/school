import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/resources/styles_manager.dart';

class CircleChoice extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Color? containerColor;
  final Color? iconColor;

  const CircleChoice(
      {super.key,
      required this.icon,
      required this.title,
      this.onTap,
      this.containerColor,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: containerColor ?? ColorManager.white,
              boxShadow: [
                BoxShadow(
                  color: ColorManager.black.withOpacity(0.1),
                  spreadRadius: 10,
                  blurRadius: 10,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(5.0.sp),
              child: FaIcon(
                icon,
                color: iconColor ?? ColorManager.darkPrimary,
                size: 16.sp,
              ),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            title,
            style: TextStyleManager.getSemiBoldStyle(
                color: ColorManager.white, fontSize: FontSize.s14.sp),
          ),
          SizedBox(
            height: 5.h,
          ),
        ],
      ),
    );
  }
}
