import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ebook/core/resources/color_manager.dart';
import 'package:ebook/core/resources/values_manager.dart';
import 'package:ebook/core/widgets/scaffolds/custom_scaffold.dart';
import 'package:ebook/features/books/data/models/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/resources/assets_manager.dart';
import '../widgets/circle_choice.dart';
import '../widgets/details_page.dart';
import '../widgets/reading_card_list.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BookPage();
  }
}

class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  GlobalKey catListKey0 = GlobalKey();
  GlobalKey catListKey1 = GlobalKey();
  GlobalKey catListKey2 = GlobalKey();
  GlobalKey catListKey3 = GlobalKey();
  GlobalKey catListKey4 = GlobalKey();
  List<GlobalKey> catListKeys = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];
  List<String> title = ["تفاصيل", "استماع", "قراءة", "امتحان"];
  List<IconData> icons = [
    FontAwesomeIcons.info,
    FontAwesomeIcons.headphones,
    FontAwesomeIcons.bookOpen,
    FontAwesomeIcons.circleQuestion
  ];
  final List<String> levelImages = [
    ImageAssets.charA,
    ImageAssets.charB,
    ImageAssets.charC,
    ImageAssets.charD,
    ImageAssets.charE,
    ImageAssets.charF,
    ImageAssets.charG,
    ImageAssets.charI,
    ImageAssets.charJ,
    ImageAssets.charK,
    ImageAssets.charL,
    ImageAssets.charM,
    ImageAssets.charN,
    ImageAssets.charO,
    ImageAssets.charP,
    ImageAssets.charQ,
    ImageAssets.charR,
    ImageAssets.charS,
  ];
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      screenTitle: "تصفح المحتوي",
      body: Column(
        children: [
          SizedBox(
            height: 40.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: levelImages.length,
              itemBuilder: (context, i) {
                return Image.asset(levelImages[i], width: 30, height: 30);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p32),
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Image.asset(
                                            ImageAssets.charP,
                                            width: 25,
                                          ),
                                          const Text(
                                            " :المستوي",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Text(
                                        "فصل الشتاء قدام",
                                        style: TextStyle(
                                            height: 1.1,
                                            fontSize: 25,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        "منير سالم",
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
                          child: listView(catListKeys[index]),
                        ),
                      ),
                      Positioned(
                          top: 0,
                          right: 0,
                          child: Image.asset(
                            ImageAssets.book1,
                            height: 180,
                          ))
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget listView(GlobalKey key) {
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
                        DetailsPage(selectedCat: index, catListOffset: _offset),
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

const categories = [
  {'name': 'Kitchen', 'icon': 'assets/images/category/kitchen.png'},
  {'name': 'Bathroom', 'icon': 'assets/images/category/bathroom.png'},
  {'name': 'Sofa', 'icon': 'assets/images/category/sofa.png'},
  {'name': 'Icebox', 'icon': 'assets/images/category/icebox.png'},
];
