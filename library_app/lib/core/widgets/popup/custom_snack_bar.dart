import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/core/resources/font_manager.dart';

import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';

void showSnackBar(BuildContext context,
    {required String message, Color? backgroundColor}) {
  final snackBar = SnackBar(
    backgroundColor: backgroundColor ?? ColorManager.darkPrimary,
    content: Text(message,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: ColorManager.white,
              fontSize: FontSize.s14.sp,
            )),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
