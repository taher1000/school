import 'dart:convert';

import 'package:library_app/core/entities/book/book.dart';
import 'package:library_app/core/resources/values_manager.dart';
import 'package:library_app/features/teacher_features/assignment/domain/entities/request/book_collection_body.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/resources/app_localization.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/styles_manager.dart';

class ExpansileTileWidget extends StatefulWidget {
  final String title;
  final String? image;
  final int index;
  final List<Widget> children;
  const ExpansileTileWidget({
    super.key,
    required this.title,
    this.image,
    required this.index,
    required this.children,
  });

  @override
  State<ExpansileTileWidget> createState() => _ExpansileTileWidgetState();
}

class _ExpansileTileWidgetState extends State<ExpansileTileWidget> {
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
        leading: widget.image != null
            ? Image.memory(base64Decode(widget.image!))
            : CircleAvatar(
                radius: 18.r,
                backgroundColor: ColorManager.darkPrimary,
                child: Text(
                  widget.index.toString(),
                  style: TextStyleManager.getSemiBoldStyle(
                      color: ColorManager.secondryLight,
                      fontSize: FontSize.s14.sp),
                ),
              ),
        elevation: 10.sp,
        expandedTextColor: ColorManager.darkPrimary,
        baseColor: ColorManager.secondryLight,
        expandedColor: ColorManager.secondryLight,
        shadowColor: ColorManager.darkPrimary,
        title: Text(
          widget.title,
          style: TextStyleManager.getMediumStyle(
              color: ColorManager.darkPrimary, fontSize: FontSize.s14.sp),
        ),
        children: widget.children,
      ),
    );
  }
}
