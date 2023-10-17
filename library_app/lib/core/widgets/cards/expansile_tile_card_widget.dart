import 'dart:convert';

import '../../resources/values_manager.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/styles_manager.dart';

class CustomExpansileTileWidget extends StatefulWidget {
  final Widget title;
  final String? image;
  final List<Widget> children;
  const CustomExpansileTileWidget({
    super.key,
    required this.title,
    this.image,
    required this.children,
  });

  @override
  State<CustomExpansileTileWidget> createState() =>
      _CustomExpansileTileWidgetState();
}

class _CustomExpansileTileWidgetState extends State<CustomExpansileTileWidget> {
  bool isReading = false;
  bool isListening = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: ExpansionTileCard(
        contentPadding: EdgeInsetsDirectional.symmetric(
            horizontal: AppPadding.p8.w, vertical: AppPadding.p16.h),
        animateTrailing: true,
        // leading: widget.image != null
        //     ? Image.asset(widget.image!)
        //     : CircleAvatar(
        //         radius: 14.r,
        //         backgroundColor: ColorManager.darkPrimary,
        //       ),
        elevation: 10.sp,
        expandedTextColor: ColorManager.darkPrimary,
        baseColor: ColorManager.secondryLight,
        expandedColor: ColorManager.secondryLight,
        shadowColor: ColorManager.darkPrimary,
        title: widget.title,
        children: widget.children,
      ),
    );
  }
}
