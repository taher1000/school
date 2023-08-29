import 'dart:convert';

import 'package:ebook/core/resources/assets_manager.dart';
import 'package:ebook/features/books/domain/enum/book_level.dart';
import 'package:ebook/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/entities/book/book.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/values_manager.dart';
import 'circle_choice.dart';
import 'details_page.dart';

class BookCardItem extends StatelessWidget {
  final GlobalKey catListKey;
  final Book book;
  const BookCardItem({super.key, required this.catListKey, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      margin: const EdgeInsets.symmetric(vertical: AppMargin.m8),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Hero(
            tag: 'blue_card',
            child: Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: 190,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15.0),
                ),
                color: ColorManager.darkPrimary,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Image.asset(
                                BookLevel.fromJson(book.bookLevel).level,
                                width: 40.w,
                                height: 40.h,
                              ),
                            ],
                          ),
                          Text(
                            book.title!,
                            style: TextStyle(
                                height: 1.1,
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            book.authorName ?? "No Author",
                            style: TextStyle(
                                fontSize: 12,
                                height: 0.2,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Hero(
              tag: "cat",
              child: listView(catListKey, context),
            ),
          ),
          Align(
            alignment: sharedPrefsClient.currentLanguage == "en"
                ? Alignment.topRight
                : Alignment.topLeft,
            // top: 0,
            // right: 20.w,
            child: book.image!.isEmpty
                ? Image.asset(
                    ImageAssets.noImage,
                    fit: BoxFit.fitWidth,
                    width: 0.35.sw,
                    height: 0.35.sw,
                  )
                : Image.memory(
                    base64Decode(book.image!),
                    fit: BoxFit.fill,
                    width: 0.4.sw,
                    height: 0.4.sw,
                    errorBuilder: (context, object, trace) => const SizedBox(),
                  ),
          )
        ],
      ),
    );
  }

  Widget listView(GlobalKey key, BuildContext context) {
    const categories = [
      {'name': 'Kitchen', 'icon': 'assets/images/category/kitchen.png'},
      {'name': 'Bathroom', 'icon': 'assets/images/category/bathroom.png'},
      {'name': 'Sofa', 'icon': 'assets/images/category/sofa.png'},
      {'name': 'Icebox', 'icon': 'assets/images/category/icebox.png'},
    ];
    List<String> title = ["تفاصيل", "استماع", "قراءة", "امتحان"];
    List<IconData> icons = [
      FontAwesomeIcons.info,
      FontAwesomeIcons.headphones,
      FontAwesomeIcons.bookOpen,
      FontAwesomeIcons.circleQuestion
    ];
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        key: key,
        height: 85,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: categories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                final _offset =
                    (key.currentContext!.findRenderObject() as RenderBox)
                        .localToGlobal(Offset.zero);
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        DetailsPage(
                      selectedCat: index,
                      catListOffset: _offset,
                      book: book,
                    ),
                    transitionDuration: const Duration(milliseconds: 500),
                    transitionsBuilder: (_, a, __, c) =>
                        FadeTransition(opacity: a, child: c),
                  ),
                );
              },
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CircleChoice(
                    title: title[index],
                    icon: icons[index],
                  )),
            );
          },
        ),
      ),
    );
  }
}
