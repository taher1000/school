import 'package:ebook/core/resources/color_manager.dart';
import 'package:ebook/core/resources/font_manager.dart';
import 'package:ebook/core/resources/styles_manager.dart';
import 'package:ebook/features/books/domain/entities/book.dart';
import 'package:flutter/material.dart';

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
          book.title ?? "No title",
          style: TextStyleManager.getBlackStyle(color: ColorManager.black),
        ),
        Text(
          book.authorName ?? "No author",
          style: TextStyleManager.getBoldStyle(
              color: ColorManager.black, fontSize: FontSize.s24),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          book.description ?? "No description",
          style: TextStyleManager.getRegularStyle(
              color: ColorManager.black, fontSize: FontSize.s14),
        ),
      ],
    );
  }
}
