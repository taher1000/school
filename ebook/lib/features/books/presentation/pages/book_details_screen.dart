import 'package:ebook/core/resources/color_manager.dart';
import 'package:ebook/core/resources/values_manager.dart';
import 'package:ebook/core/widgets/buttons/rounded_button.dart';
import 'package:ebook/core/widgets/scaffolds/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/book.dart';

class BookDetailsScreen extends StatefulWidget {
  final Book book;

  const BookDetailsScreen({Key? key, required this.book}) : super(key: key);

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      screenTitle: "Book Details",
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 360.h,
                      decoration: BoxDecoration(
                        color: ColorManager.darkPrimary,
                        borderRadius: BorderRadius.circular(24.h),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(10, -5),
                            blurRadius: 22,
                            color: ColorManager.darkPrimary.withOpacity(0.2),
                          ),
                        ],
                      ),

                      //MediaQuery.of(context).size.height * 0.55,
                      child: Column(
                        children: [
                          Center(
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10.h),
                                  height: 190.h,
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                      color:
                                          ColorManager.grey1.withOpacity(0.3),
                                      // spreadRadius: 1,
                                      blurRadius: 30,
                                      // offset: Offset(1, -1),
                                    )
                                  ]),
                                  //MediaQuery.of(context).size.height * 0.3,
                                  child: Image(
                                    // height: 100,
                                    image: AssetImage(widget.book.image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  height: AppSize.s10,
                                ),
                                Text(
                                  "Title: ${widget.book.title}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  height: AppSize.s4,
                                ),
                                Text(
                                  "Publisher: ${widget.book.publisher}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Author: ${widget.book.author}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Pages count: ${widget.book.pagesCount}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Words count: ${widget.book.wordsCount}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Reading Level: ${widget.book.level}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Description",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: ColorManager.black),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.book.description,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: ColorManager.black),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.12,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: const EdgeInsets.all(AppPadding.p16),
                child: CustomRoundedButton(text: 'Read Now', onPressed: () {})),
          ),
        ],
      ),
    );
  }
}
