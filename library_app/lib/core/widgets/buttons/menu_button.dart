import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';

class MenuButton extends StatelessWidget {
  final IconData iconPath;
  final String title;
  final String route;
  const MenuButton(
      {super.key,
      required this.iconPath,
      required this.title,
      required this.route});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20.r),
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
      child: Container(
        height: 80.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              width: 1.0.w,
              color: ColorManager.darkGrey,
            )),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.sp),
              margin: EdgeInsets.symmetric(horizontal: 10.0.sp),
              height: 65.h,
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                  color: ColorManager.secondryLight,
                  borderRadius: BorderRadius.circular(8.0)),
              width: 70.w,
              child: FaIcon(iconPath,
                  color: ColorManager.darkPrimary, size: 26.sp),
            ),
            SizedBox(
              width: 10.w,
            ),
            SizedBox(
              width: 160.w,
              child: Text(
                title,
                style: TextStyleManager.getSemiBoldStyle(
                  color: ColorManager.darkPrimary,
                  fontSize: FontSize.s14.sp,
                ),
              ),
            ),
            const Spacer(),
            CircleAvatar(
              backgroundColor: ColorManager.darkPrimary,
              radius: 17.5.r,
              child: Icon(
                Icons.arrow_forward,
                size: 22.5.sp,
                color: ColorManager.white,
              ),
            ),
            SizedBox(width: 15.0.w),
          ],
        ),
      ),
    );
  }
}
