import '../../../../core/entities/book/book.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/routes_manager.dart';
import '../../../student_features/my_favorites/presentation/bloc/cubit/is_favorite_book_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/resources/app_localization.dart';
import '../../../../injection_container.dart';
import '../../../student_features/my_favorites/presentation/bloc/cubit/add_favorite_book_cubit.dart';
import 'circle_choice.dart';
import 'book_details_page.dart';

class BookCircleChoicesList extends StatelessWidget {
  final GlobalKey? globalKey;
  final bool isAssignment;
  final Book book;
  const BookCircleChoicesList(
      {super.key,
      required this.globalKey,
      required this.book,
      this.isAssignment = false});

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;

    return Material(
      color: Colors.transparent,
      child: SizedBox(
        key: globalKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleChoice(
              title: localize("details"),
              icon: FontAwesomeIcons.info,
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        MultiBlocProvider(
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
            ),
            if (book.hasListening)
              CircleChoice(
                title: localize("listening"),
                icon: FontAwesomeIcons.headphones,
                onTap: () {
                  CustomNavigator.push(
                    Routes.audioReaderRoute,
                    arguments: {
                      "bookId": book.id,
                    },
                  );
                },
              ),
            if (book.hasReading)
              CircleChoice(
                title: localize("reading"),
                iconColor: book.hasReading ? ColorManager.green : null,
                // containerColor: book.hasReading ? ColorManager.green : null,
                icon: FontAwesomeIcons.bookOpen,
                onTap: () {
                  CustomNavigator.push(
                    Routes.readerRoute,
                    // replace: true,
                    arguments: {
                      "bookId": book.id,
                      "pagesCount": book.pageCount,
                    },
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
