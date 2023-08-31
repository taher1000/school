import 'package:ebook/core/entities/book/book.dart';
import 'package:ebook/core/navigation/custom_navigation.dart';
import 'package:ebook/core/resources/routes_manager.dart';
import 'package:ebook/features/student_features/my_favorites/presentation/bloc/cubit/is_favorite_book_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/resources/app_localization.dart';
import '../../../../injection_container.dart';
import '../../../student_features/my_favorites/presentation/bloc/cubit/add_favorite_book_cubit.dart';
import 'circle_choice.dart';
import 'details_page.dart';

class CircleChoiceList extends StatelessWidget {
  final GlobalKey? globalKey;
  final Book book;
  const CircleChoiceList(
      {super.key, required this.globalKey, required this.book});

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;

    List<String> title = [
      localize("details"),
      localize("listening"),
      localize("reading"),
      localize("exam")
    ];
    List<IconData> icons = [
      FontAwesomeIcons.info,
      FontAwesomeIcons.headphones,
      FontAwesomeIcons.bookOpen,
      FontAwesomeIcons.circleQuestion
    ];
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        key: globalKey,
        height: 85,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: icons.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                if (index == 0) {
                  final offset = (globalKey!.currentContext?.findRenderObject()
                          as RenderBox)
                      .localToGlobal(Offset.zero);

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
                          selectedCat: index,
                          catListOffset: offset,
                          book: book,
                        ),
                      ),
                      transitionDuration: const Duration(milliseconds: 500),
                      transitionsBuilder: (_, a, __, c) =>
                          FadeTransition(opacity: a, child: c),
                    ),
                  );
                } else if (index == 1) {
                  CustomNavigator.pushInSubNavigator(Routes.readerRoute);
                }
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
