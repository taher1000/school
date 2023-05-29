import 'package:ebook/core/resources/assets_manager.dart';
import 'package:ebook/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/resources/values_manager.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shadowColor: ColorManager.darkPrimary,
      elevation: AppSize.s4,
      borderRadius: BorderRadius.circular(AppSize.s50),
      child: Container(
        width: double.infinity,
        height: 45.h,
        decoration: BoxDecoration(
            color: ColorManager.darkPrimary,
            border: Border.all(
              color: ColorManager.darkPrimary,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(AppSize.s50)),
        child: Stack(
          children: [
            // LayoutBuider provide the available space for the container
            // constraints.maxWidth need for animation
            LayoutBuilder(
                builder: (context, constraints) => Container(
                      width: 200,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              ColorManager.darkPrimary,
                              ColorManager.primary
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            stops: [0.4, 0.8],
                          ),
                          borderRadius: BorderRadius.circular(50)),
                    )),
            Positioned.fill(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppPadding.p16 - 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${2} ${(2) > 1 ? "seconds" : "second"}"),
                    SvgPicture.asset("assets/icons/clock.svg")
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: AppPadding.p8),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: SvgPicture.asset(SvgAssets.clock)),
            ),
          ],
        ),
      ),
    );
  }
}
