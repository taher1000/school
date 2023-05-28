import '../resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/color_manager.dart';

class InfoContainerWidget extends StatelessWidget {
  final String svgIcon;
  final String title;
  const InfoContainerWidget({
    super.key,
    required this.svgIcon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.s160.w,
      height: AppSize.s170.h,
      decoration: BoxDecoration(
        color: ColorManager.secondryLight,
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSize.s20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(svgIcon),
            SizedBox(height: AppSize.s20.h),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: ColorManager.black),
            ),
            SizedBox(height: AppSize.s10.h),
          ],
        ),
      ),
    );
  }
}
