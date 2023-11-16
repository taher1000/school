import 'dart:convert';

import '../../../../core/blocs/app_theme_cubit/app_theme_cubit.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../domain/enum/book_level.dart';
import 'book_circle_options_list.dart';
import '../../../student_features/my_favorites/presentation/bloc/cubit/add_favorite_book_cubit.dart';
import '../../../../injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/entities/book/book.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../student_features/my_favorites/presentation/bloc/cubit/is_favorite_book_cubit.dart';
import 'book_details_page.dart';

class BookCardItem extends StatelessWidget {
  final Book book;
  final bool isAssignment;
  const BookCardItem(
      {super.key, required this.book, this.isAssignment = false});

  @override
  Widget build(BuildContext context) {
    final deviceType = ScreenUtil().deviceType();
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
      child: BlocBuilder<AppThemeCubit, AppThemeState>(
        builder: (context, state) {
          return Container(
            height: 300.h,
            margin: const EdgeInsets.symmetric(vertical: AppMargin.m8),
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppPadding.p12.w, vertical: AppPadding.p16.h),
                  width: MediaQuery.of(context).size.width,
                  height: deviceType == DeviceType.tablet ? 200.h : 190,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0.r),
                    ),
                    color: state.themeMode == ThemeMode.dark
                        ? ColorManager.darkGrey
                        : ColorManager.darkPrimary,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            book.title,
                            style: TextStyleManager.getSemiBoldStyle(
                                color: state.themeMode == ThemeMode.dark
                                    ? ColorManager.grey
                                    : ColorManager.white,
                                fontSize: FontSize.s24.sp),
                          ),
                          const Spacer(),
                          Image.asset(
                            BookLevel.fromJson(book.bookLevel).level,
                            fit: BoxFit.cover,
                            width: 30.w,
                            height: 45.h,
                          ),
                          const Spacer(
                            flex: 9,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        book.authorName,
                        style: TextStyleManager.getRegularStyle(
                            color: ColorManager.white,
                            fontSize: FontSize.s12.sp),
                      ),
                    ],
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BookCircleChoicesList(
                      globalKey: GlobalKey(),
                      book: book,
                      isAssignment: isAssignment,
                    ),
                  ),
                ),
                Positioned(
                    top: 30.h,
                    right: isRtl ? null : 20.w,
                    left: !isRtl ? null : 20.w,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        book.image.isEmpty
                            ? Image.asset(
                                ImageAssets.noImage,
                                fit: BoxFit.fitWidth,
                                width: 0.35.sw,
                                height: 0.35.sw,
                              )
                            : Image.memory(
                                base64Decode(book.image),
                                fit: BoxFit.fill,
                                width: deviceType == DeviceType.tablet
                                    ? 0.2.sw
                                    : .4.sw,
                                height: deviceType == DeviceType.tablet
                                    ? 0.2.sw
                                    : .4.sw,
                                errorBuilder: (context, object, trace) =>
                                    const SizedBox(),
                              ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ))
              ],
            ),
          );
        },
      ),
    );
  }
}
