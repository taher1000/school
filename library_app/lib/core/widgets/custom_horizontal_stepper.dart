import '../resources/font_manager.dart';

import '../resources/color_manager.dart';
import 'text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHorizontalStepper extends StatelessWidget {
  const CustomHorizontalStepper(
      {super.key,
      required this.steps,
      this.onStepTap,
      required this.currentStep,
      this.lastIconColor,
      this.inactiveColor,
      this.labels,
      this.height});
  final List<Widget> steps;
  final Function(int)? onStepTap;
  final int currentStep;
  final Color? lastIconColor;
  final Color? inactiveColor;
  final List? labels;
  final double? height;

  List<Widget> _iconViews() {
    var list = <Widget>[];
    for (int i = 0; i < steps.length; i++) {
      list.add(
        InkWell(
          onTap: () {
            if (onStepTap != null) onStepTap!(i);
          },
          child: Container(
            width: height ?? 30.0.w,
            height: height ?? 30.0.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white),
              color: i == currentStep
                  ? ColorManager.darkPrimary
                  : i <= currentStep
                      ? ColorManager.darkPrimary
                      : (inactiveColor ?? ColorManager.darkGreyText),
            ),
            child: (labels == null)
                ? Center(
                    child: CustomText(
                    "${i + 1}",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: FontSize.s16.sp),
                  ))
                : const SizedBox(),
          ),
        ),
      );

      //line between icons
      if (i != steps.length - 1) {
        list.add(Expanded(
            child: Container(
          height: 1,
          color: const Color(0xFF707070),
        )));
      }
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(children: [
          Row(
            children: _iconViews(),
          ),
          if (labels != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...labels!.map((e) => Row(
                      children: [
                        CustomText(
                          e,
                          style: TextStyle(
                            color: ColorManager.darkPrimary,
                            height: 2,
                            fontSize: 8.sp,
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          Expanded(child: steps[currentStep])
        ]));
  }
}
