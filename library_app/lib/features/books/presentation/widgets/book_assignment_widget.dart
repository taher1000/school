import 'dart:convert';

import '../../../../core/entities/book/book.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../teacher_features/assignment/domain/entities/request/book_collection_body.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/resources/app_localization.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../domain/enum/book_level.dart';
import '../cubit/book_selection_cubit.dart';

class BookAssignmentWidget extends StatefulWidget {
  final Book book;
  const BookAssignmentWidget({
    super.key,
    required this.book,
  });

  @override
  State<BookAssignmentWidget> createState() => _BookAssignmentWidgetState();
}

class _BookAssignmentWidgetState extends State<BookAssignmentWidget> {
  bool isReading = false;
  bool isListening = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTileCard(
        animateTrailing: true,
        leading: Image.memory(base64Decode(widget.book.image)),
        elevation: 10.r,
        expandedTextColor: ColorManager.darkPrimary,
        baseColor: ColorManager.secondryLight,
        expandedColor: ColorManager.secondryLight,
        shadowColor: ColorManager.darkPrimary,
        title: Text(
          widget.book.title,
          style: TextStyleManager.getBoldStyle(
              color: ColorManager.darkPrimary, fontSize: FontSize.s16.sp),
        ),
        subtitle: Text(
          widget.book.authorName,
          style: TextStyleManager.getRegularStyle(
              color: ColorManager.greyDark, fontSize: FontSize.s10.sp),
        ),
        children: <Widget>[
          Divider(
            thickness: 1.0.h,
            height: 1.0.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.p16.w,
              vertical: AppPadding.p8.h,
            ),
            child: Text(
              AppLocalization.of(context).getTranslatedValues("book_details"),
              style: TextStyleManager.getBoldStyle(
                  color: ColorManager.darkPrimary, fontSize: FontSize.s14.sp),
            ),
          ),
          ListTile(
            title: Text(
              widget.book.description,
              style: TextStyleManager.getRegularStyle(
                  color: ColorManager.darkPrimary, fontSize: FontSize.s12.sp),
            ),
            subtitle: Image.asset(
              BookLevel.fromJson(widget.book.bookLevel).level,
              width: 40.w,
              height: 40.h,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              checkBoxItem(Icons.headphones, "listening", (bool? value) {
                setState(() {
                  isListening = value!;
                });
                BlocProvider.of<BookSelectionCubit>(context).addBook(
                    BookCollection(
                        bookId: widget.book.id,
                        hasBookRead: isReading,
                        hasBookAudio: isListening));
              }, isListening),
              checkBoxItem(FontAwesomeIcons.bookOpen, "reading", (bool? value) {
                setState(() {
                  isReading = value!;
                });
                BlocProvider.of<BookSelectionCubit>(context).addBook(
                    BookCollection(
                        bookId: widget.book.id,
                        hasBookRead: isReading,
                        hasBookAudio: isListening));
              }, isReading),
            ],
          )
        ],
      ),
    );
  }

  Widget checkBoxItem(final IconData icon, final String title,
      final void Function(bool?)? onChanged, bool? value) {
    return SizedBox(
      width: 150.w,
      child: ListTile(
        //                   ,
        // FontAwesomeIcons.bookOpen,
        // FontAwesomeIcons.circleQuestion
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10.h),
            Icon(
              icon,
              size: 30.sp,
              color: ColorManager.darkPrimary,
            ),
            Transform.scale(
              scale: 1.25.r,
              child: Checkbox(
                side: BorderSide(color: ColorManager.darkPrimary, width: 2.r),
                activeColor: ColorManager.darkPrimary,
                checkColor: Colors.white,
                value: value,
                onChanged: onChanged,
              ),
            ),
          ],
        ),

        title: Text(
          AppLocalization.of(context).getTranslatedValues(title),
          style: TextStyleManager.getMediumStyle(
            color: ColorManager.darkPrimary,
            fontSize: FontSize.s18,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
