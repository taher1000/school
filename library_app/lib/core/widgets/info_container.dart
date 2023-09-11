import '../resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/color_manager.dart';

class InfoContainerWidget extends StatelessWidget {
  final String svgIcon;
  final String title;
  final VoidCallback onTap;
  const InfoContainerWidget({
    super.key,
    required this.svgIcon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(svgIcon,
                  colorFilter: ColorFilter.mode(
                      ColorManager.darkPrimary, BlendMode.srcIn),
                  height: 25),
              SizedBox(height: AppSize.s20.h),
              Container(
                constraints: BoxConstraints(
                  maxHeight: AppSize.s55.h,
                  maxWidth: AppSize.s160.w,
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.fade,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: ColorManager.darkPrimary,
                      ),
                ),
              ),
              SizedBox(height: AppSize.s10.h),
            ],
          ),
        ),
      ),
    );
  }
}
