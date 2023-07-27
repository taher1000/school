import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/values_manager.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: AppPadding.p12, horizontal: AppPadding.p8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s16),
          color: Colors.transparent,
          border: Border.all(
            color: ColorManager.grey,
            width: 2,
          )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 90.w,
            height: 100.h,
            decoration: BoxDecoration(
              color: ColorManager.grey,
              borderRadius: BorderRadius.circular(AppSize.s16),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Taher Fawaz',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: ColorManager.black,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: AppSize.s12),
              Text(
                'Class: Y Purple  |  Level: B',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      // color: ColorManager.greyTextColor,
                      fontSize: FontSize.s18,
                    ),
              ),
            ],
          ),
          SvgPicture.asset(SvgAssets.camera)
        ],
      ),
    );
  }
}
