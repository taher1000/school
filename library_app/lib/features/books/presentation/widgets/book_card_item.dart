import 'dart:convert';

import 'package:library_app/core/resources/assets_manager.dart';
import 'package:library_app/core/resources/font_manager.dart';
import 'package:library_app/core/resources/styles_manager.dart';
import 'package:library_app/features/books/domain/enum/book_level.dart';
import 'package:library_app/features/books/presentation/widgets/circle_choice_list.dart';
import 'package:library_app/features/student_features/my_favorites/presentation/bloc/cubit/add_favorite_book_cubit.dart';
import 'package:library_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/entities/book/book.dart';
import '../../../../core/resources/app_localization.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../student_features/my_favorites/presentation/bloc/cubit/is_favorite_book_cubit.dart';
import 'circle_choice.dart';
import 'book_details_page.dart';

class BookCardItem extends StatelessWidget {
  final Book book;
  final bool isAssignment;
  const BookCardItem(
      {super.key, required this.book, this.isAssignment = false});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);

    final isRtl = locale.languageCode.toLowerCase() == 'ar';
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => MultiBlocProvider(
              providers: [
                BlocProvider<AddFavoriteBookCubit>(
                  create: (context) => AddFavoriteBookCubit(getIt()),
                ),
                BlocProvider<IsFavoriteBookCubit>(
                  create: (context) => IsFavoriteBookCubit(getIt()),
                ),
              ],
              child: BookDetailsScreen(
                isAssignment: isAssignment,
                selectedCat: 0,
                book: book,
              ),
            ),
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c),
          ),
        );
      },
      child: Container(
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
                height: 175.h,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                  color: ColorManager.darkPrimary,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      BookLevel.fromJson(book.bookLevel).level,
                      width: 40.w,
                      height: 40.h,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      book.title,
                      style: TextStyleManager.getSemiBoldStyle(
                          color: ColorManager.white, fontSize: FontSize.s28.sp),
                    ),
                    Text(
                      book.authorName,
                      style: TextStyleManager.getRegularStyle(
                          color: ColorManager.white),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              // top: -0,
              child: Hero(
                  tag: "cat",
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleChoiceList(
                      globalKey: GlobalKey(),
                      book: book,
                      isAssignment: isAssignment,
                    ),
                  )),
            ),
            Align(
              alignment: isRtl ? Alignment.topLeft : Alignment.topRight,
              // top: 0,
              // right: 20.w,
              child: book.image.isEmpty
                  ? Image.asset(
                      ImageAssets.noImage,
                      fit: BoxFit.fitWidth,
                      width: 0.35.sw,
                      height: 0.35.sw,
                    )
                  : Image.memory(
                      base64Decode(book.image),
                      fit: BoxFit.fill,
                      width: 0.2.sw,
                      height: 0.2.sw,
                      errorBuilder: (context, object, trace) =>
                          const SizedBox(),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
