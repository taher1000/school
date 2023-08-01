import 'package:ebook/core/resources/color_manager.dart';
import 'package:ebook/core/resources/font_manager.dart';
import 'package:ebook/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class BookInfo extends StatelessWidget {
  const BookInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "فصل الشتاء قادم",
          style: TextStyleManager.getBlackStyle(color: ColorManager.black),
        ),
        Text(
          "منير سالم",
          style: TextStyleManager.getBoldStyle(
              color: ColorManager.black, fontSize: FontSize.s24),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "هذا وصف الكتاب الذي يتكون من عدة أسطر ويتم تحديد عدد الأسطر بناءً على الحجم الذي يتم تحديده للنص",
          style: TextStyleManager.getRegularStyle(
              color: ColorManager.black, fontSize: FontSize.s14),
        ),
      ],
    );
  }
}
