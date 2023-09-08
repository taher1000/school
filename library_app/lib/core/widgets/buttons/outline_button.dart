import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/color_manager.dart';

class CustomOutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomOutlineButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Ink(
        width: double.infinity,
        height: 70.h,
        decoration: BoxDecoration(
          border: Border.all(color: ColorManager.black),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Text(text,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: ColorManager.black)),
        ),
      ),
    );
  }
}
