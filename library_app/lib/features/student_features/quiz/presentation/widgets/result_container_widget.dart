import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/resources/app_localization.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/values_manager.dart';

class ResultContainerWidget extends StatelessWidget {
  final Color cardColor;
  final Color borderColor;
  final String result;
  final String text;

  const ResultContainerWidget(
      {super.key,
      required this.cardColor,
      required this.result,
      required this.text,
      required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // margin:
      //     EdgeInsets.symmetric(horizontal: 20.w),
      width: 170.w,
      // height: 150,
      child: Card(
        color: cardColor,
        elevation: 10.sp,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(color: borderColor, width: 3)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: AppPadding.p8.h, horizontal: AppPadding.p16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                result,
                style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: ColorManager.darkPrimary,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                AppLocalization.of(context).getTranslatedValues(text),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: ColorManager.darkPrimary,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
