// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:library_app/core/blocs/app_theme_cubit/app_theme_cubit.dart';
import 'package:library_app/core/resources/assets_manager.dart';
import 'package:library_app/features/books/presentation/widgets/book_circle_options_list.dart';
import 'package:library_app/features/student_features/my_favorites/presentation/bloc/cubit/add_favorite_book_cubit.dart';
import 'package:library_app/features/student_features/my_favorites/presentation/bloc/cubit/is_favorite_book_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/entities/assignment/student_assignment.dart';
import '../../../../core/entities/book/book.dart';
import '../../../../core/resources/app_localization.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/widgets/popup/custom_snack_bar.dart';
import '../../../../core/widgets/scaffolds/main_scaffold.dart';
import 'book_info.dart';
import 'circle_choice.dart';

const colors = [
  {"colorName": "yellow", "color": Color(0xFFF2D337)},
  {"colorName": "blue", "color": Color(0xFF6C9DFD)},
  {"colorName": "green", "color": Color(0xFF7DD222)},
];

class BookDetailsScreen extends StatefulWidget {
  final int selectedCat;
  final Book book;
  final bool isAssignment;

  const BookDetailsScreen(
      {super.key,
      required this.selectedCat,
      required this.book,
      this.isAssignment = false});

  @override
  _BookDetailsScreenState createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen>
    with TickerProviderStateMixin {
  int selectedCat = 0;

  GlobalKey imageKey = GlobalKey();

  List<String> title = ["details", "listening", "reading", "exam"];
  List<IconData> icons = [
    FontAwesomeIcons.info,
    FontAwesomeIcons.headphones,
    FontAwesomeIcons.bookOpen,
    FontAwesomeIcons.circleQuestion
  ];

  @override
  void initState() {
    BlocProvider.of<IsFavoriteBookCubit>(context)
        .isFavoriteBook(widget.book.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      canPop: true,
      body: BlocBuilder<AppThemeCubit, AppThemeState>(
        builder: (context, themeState) {
          return Stack(
            children: [
              TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 600),
                  tween: Tween(begin: 1, end: 0),
                  builder: (context, double value, _) {
                    return Hero(
                        tag: 'blue_card',
                        child: Material(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: themeState.themeMode == ThemeMode.light
                                  ? ColorManager.darkPrimary
                                  : ColorManager.darkGrey,
                              borderRadius: BorderRadius.circular(value * 15),
                            ),
                          ),
                        ));
                  }),
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: BookCircleChoicesList(
                  globalKey: GlobalKey(),
                  book: widget.book,
                  isAssignment: widget.isAssignment,
                ),
              ),
              // Positioned(
              //   top: widget.catListOffset.dy,
              //   child: categoryWithTag(),
              // ),
              Positioned(
                top: 100.h,
                right: 0,
                left: 0,
                bottom: 0,
                child: SlideInUp(
                  delay: const Duration(milliseconds: 1200),
                  duration: const Duration(milliseconds: 600),
                  from: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(35.0),
                            topRight: Radius.circular(35.0),
                          ),
                          color: themeState.themeMode == ThemeMode.light
                              ? Colors.white
                              : ColorManager.greyDark,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                height: 4,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: AppPadding.p24),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      SizedBox(
                                        height: 200,
                                        width: 200,
                                        child: widget.book.image.isEmpty
                                            ? Image.asset(ImageAssets.noImage,
                                                fit: BoxFit.cover)
                                            : Image.memory(
                                                base64Decode(widget.book.image),
                                                fit: BoxFit.cover,
                                                key: imageKey,
                                              ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      BookInfo(book: widget.book),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 25.h,
                        right: 10.w,
                        child: Stack(
                          key: GlobalKey(),
                          alignment: AlignmentDirectional.center,
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: themeState.themeMode == ThemeMode.light
                                    ? ColorManager.darkPrimary
                                    : ColorManager.darkGrey,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Center(
                                child: BlocConsumer<AddFavoriteBookCubit,
                                    AddFavoriteBookState>(
                              listener: (context, state) {
                                if (state is AddFavoriteBookSuccess) {
                                  showCustomSnackBar(context,
                                      message: state.message,
                                      themeMode: themeState.themeMode);

                                  context.loaderOverlay.hide();
                                  BlocProvider.of<IsFavoriteBookCubit>(context)
                                      .isFavoriteBook(widget.book.id);
                                } else if (state is AddFavoriteBookError) {
                                  context.loaderOverlay.hide();
                                  showCustomSnackBar(context,
                                      message: state.message,
                                      backgroundColor: ColorManager.error);
                                }
                              },
                              builder: (context, state) {
                                if (state is AddFavoriteBookLoading) {
                                  return const CircularProgressIndicator();
                                }

                                return IconButton(
                                  onPressed: state is AddFavoriteBookLoading
                                      ? null
                                      : () {
                                          BlocProvider.of<AddFavoriteBookCubit>(
                                                  context)
                                              .addFavoriteBook(widget.book.id);
                                        },
                                  icon: BlocBuilder<IsFavoriteBookCubit,
                                      IsFavoriteBookState>(
                                    builder: (context, state) {
                                      if (state is IsFavoriteBookLoading) {
                                        return const CircularProgressIndicator();
                                      } else if (state
                                          is IsFavoriteBookLoaded) {
                                        return FaIcon(
                                          FontAwesomeIcons.solidHeart,
                                          color: state.isFavorite
                                              ? ColorManager.error
                                              : ColorManager.white,
                                          size: 25,
                                        );
                                      } else if (state is IsFavoriteBookError) {
                                        return FaIcon(
                                          FontAwesomeIcons.solidHeart,
                                          color: ColorManager.white,
                                          size: 25,
                                        );
                                      } else {
                                        return const CircularProgressIndicator();
                                      }
                                    },
                                  ),
                                );
                              },
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget categoryWithTag() {
    final localize = AppLocalization.of(context).getTranslatedValues;

    return FadeOut(
      child: Hero(
        tag: "cat",
        child: Material(
          color: Colors.transparent,
          child: SingleChildScrollView(
            child: SizedBox(
              height: 90,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: icons.length,
                padding: const EdgeInsets.only(left: 5),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CircleChoice(
                      title: localize(title[index]),
                      icon: icons[index],
                      onTap: () {},
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
