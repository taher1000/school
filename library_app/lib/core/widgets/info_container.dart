import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/app_theme_cubit/app_theme_cubit.dart';

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
      child: BlocBuilder<AppThemeCubit, AppThemeState>(
        builder: (context, state) {
          return Container(
            width: AppSize.s160.w,
            height: AppSize.s200.h,
            decoration: BoxDecoration(
              color: state.themeMode == ThemeMode.light
                  ? ColorManager.secondryLight
                  : ColorManager.darkGrey,
              borderRadius: BorderRadius.all(
                Radius.circular(AppSize.s10.r),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(svgIcon,
                    colorFilter: ColorFilter.mode(
                        ColorManager.darkPrimary, BlendMode.srcIn),
                    height: AppSize.s28.h),
                SizedBox(height: AppSize.s4.h),
                Container(
                  constraints: BoxConstraints(
                    maxHeight: AppSize.s80.h,
                    maxWidth: AppSize.s160.w,
                  ),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: ColorManager.darkPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                SizedBox(height: AppSize.s10.h),
              ],
            ),
          );
        },
      ),
    );
  }
}
