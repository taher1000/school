import 'dart:convert';

import 'package:ebook/core/resources/app_localization.dart';
import 'package:ebook/core/resources/color_manager.dart';
import 'package:ebook/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/entities/book/book.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../domain/enum/book_level.dart';

class TeacherBookCardItem extends StatefulWidget {
  final Book book;

  const TeacherBookCardItem(this.book, {super.key});

  @override
  State<TeacherBookCardItem> createState() => _TeacherBookCardItemState();
}

class _TeacherBookCardItemState extends State<TeacherBookCardItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 16, bottom: 10, top: 10),
      child: GestureDetector(
        onTap: () {},
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [.5, 1],
                // tileMode: TileMode.mirror,
                colors: [
                  ColorManager.darkPrimary,
                  ColorManager.primary,
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              // color: ColorManager.darkPrimary,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 7),
                  GestureDetector(
                    child: Row(
                      children: [
                        CircleAvatar(
                            backgroundColor: ColorManager.white, radius: 6),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: SizedBox(
                            width: 170,
                            child: Text(
                              widget.book.title,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Image.asset(
                            BookLevel.fromJson(widget.book.bookLevel).level,
                            width: 40.w,
                            height: 40.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(
                    height: 7,
                  ),
                  GestureDetector(
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            infoListTile(
                              Icons.published_with_changes_sharp,
                              "publisher_house",
                              "${widget.book.publisherName}",
                              context,
                            ),
                            const SizedBox(height: 7),
                            infoListTile(
                              Icons.person,
                              "author",
                              widget.book.authorName,
                              context,
                            ),
                            const SizedBox(height: 7),
                            infoListTile(
                              Icons.description,
                              "description",
                              widget.book.description,
                              context,
                            ),
                            const SizedBox(height: 7),
                            infoListTile(
                              Icons.language,
                              "book_language",
                              widget.book.bookLanguage,
                              context,
                            ),
                            const SizedBox(height: 7),
                            infoListTile(
                              Icons.list,
                              "number_of_pages",
                              widget.book.pageCount.toString(),
                              context,
                            ),
                            const SizedBox(height: 7),
                            infoListTile(
                              Icons.calculate,
                              "number_of_words",
                              widget.book.wordCount.toString(),
                              context,
                            ),
                          ],
                        ),
                        const Spacer(),
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(15), // Image border
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(50), // Image radius
                            child: widget.book.image.isEmpty
                                ? Image.asset(
                                    ImageAssets.noImage,
                                    fit: BoxFit.fitWidth,
                                  )
                                : Image.memory(
                                    base64Decode(widget.book.image),
                                    fit: BoxFit.fill,
                                    errorBuilder: (context, object, trace) =>
                                        const SizedBox(),
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row infoListTile(
      IconData icon, String text, String? value, BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Text.rich(
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              TextSpan(
                  text: ("${localize(text)}: "),
                  style: TextStyleManager.getRegularStyle(
                      color: ColorManager.white, fontSize: FontSize.s10),
                  children: <InlineSpan>[
                    TextSpan(
                        text: value ?? "",
                        style: TextStyleManager.getMediumStyle(
                            color: ColorManager.white, fontSize: FontSize.s12))
                  ])
              // Padding(
              //   padding: const EdgeInsets.only(left: 5.0),
              //   child: SizedBox(
              //     width: 170,
              //     child: Text(title,
              //         style: TextStyleManager.getMediumStyle(
              //             color: ColorManager.white, fontSize: FontSize.s14)),
              //   ),
              // ),
              ),
        )
      ],
    );
  }

  void toast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 15.0);
  }

  showProgressDialog(BuildContext context) {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => true,
              child: const SimpleDialog(
                  backgroundColor: Colors.white,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 1,
                        ),
                      ]),
                    )
                  ]));
        });
  }
}
