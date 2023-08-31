import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/entities/book/book.dart';
import '../../../../core/resources/app_localization.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import 'package:flutter/material.dart';

import '../../domain/enum/book_level.dart';

class BookInfo extends StatelessWidget {
  final Book book;
  const BookInfo({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          book.title,
          style: TextStyleManager.getBoldStyle(
              color: ColorManager.black, fontSize: FontSize.s36),
        ),
        Image.asset(
          BookLevel.fromJson(book.bookLevel).level,
          width: 40.w,
          height: 40.h,
        ),
        text("author", book.authorName, context),
        text("publisher_house", book.publisherName, context),
        text("book_language", book.bookLanguage, context),
        text("number_of_pages", book.pageCount.toString(), context),
        text("number_of_words", book.wordCount.toString(), context),
        text("description", book.description, context),
      ],
    );
  }

  Widget text(String text, String? value, BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;
    return Text.rich(TextSpan(
        text: ("${localize(text)}: "),
        style: TextStyleManager.getRegularStyle(
            color: ColorManager.black, fontSize: FontSize.s16),
        children: <InlineSpan>[
          TextSpan(
              text: value ?? "",
              style: TextStyleManager.getSemiBoldStyle(
                  color: ColorManager.black, fontSize: FontSize.s22))
        ]));
  }
}
