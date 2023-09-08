import '../resources/font_manager.dart';
import '../resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';

class MainInfoContainer extends StatelessWidget {
  final String svgIcon;
  final String title;
  final String desc;
  const MainInfoContainer(
      {super.key,
      required this.svgIcon,
      required this.title,
      required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.s160.w,
      height: ScreenUtil().scaleHeight * 250,
      decoration: BoxDecoration(
        color: ColorManager.secondryLight,
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(svgIcon),
            SizedBox(height: AppSize.s20.h),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: ColorManager.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            SizedBox(height: AppSize.s10.h),
            Text(
              desc,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(),
            ),
          ],
        ),
      ),
    );
  }
}
