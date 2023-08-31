import 'dart:async';

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:dio/dio.dart';
import 'package:ebook/core/entities/book/book.dart';
import 'package:ebook/core/resources/app_localization.dart';
import 'package:ebook/core/widgets/loading/list_shimmer_loading.dart';
import 'package:ebook/core/widgets/loading/refresh_indicator.dart';
import 'package:ebook/core/widgets/text/empty_widget.dart';
import 'package:ebook/features/books/presentation/widgets/book_card_item.dart';
import 'package:ebook/features/student_features/my_books/presentation/bloc/my_books_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';

import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';
import '../../../../books/presentation/widgets/book_levels_list.dart';

class StudentMyBooksScreen extends StatefulWidget {
  const StudentMyBooksScreen({super.key});

  @override
  State<StudentMyBooksScreen> createState() => _StudentMyBooksScreenState();
}

class _StudentMyBooksScreenState extends State<StudentMyBooksScreen> {
  @override
  void initState() {
    BlocProvider.of<MyBooksBloc>(context)
        .pagingController
        .addPageRequestListener((pageKey) {
      BlocProvider.of<MyBooksBloc>(context).add(const FetchMyBooks());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      canPop: false,
      screenTitle: AppLocalization.of(context).getTranslatedValues("my_books")!,
      body: MyRefreshIndicator(
        onRefresh: () {
          final Completer<void> completer = Completer<void>();

          BlocProvider.of<MyBooksBloc>(context).add(const FetchMyBooks());
          completer.complete();
          return completer.future;
        },
        widget: BlocConsumer<MyBooksBloc, MyBooksState>(
          listener: (context, state) {
            if (state is GetMyBooksLoading) {
              context.loaderOverlay.show();
            }
            if (state is GetMyBooksError) {
              context.loaderOverlay.hide();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
            if (state is MyBooksLoaded) {
              context.loaderOverlay.hide();
            }
          },
          builder: (context, state) {
            if (state is GetMyBooksLoading) {
              return const ListShimmerLoadingWidget();
            }
            return Expanded(
              child: Column(
                children: [
                  SizedBox(
                      height: 50,
                      child: BookLevelList(
                        onLevelSelected: (level) {
                          BlocProvider.of<MyBooksBloc>(context)
                              .add(FetchMyBooks(bookLevel: level));
                        },
                      )),
                  Expanded(
                    child: PagedListView<int, Book>(
                      pagingController: BlocProvider.of<MyBooksBloc>(context)
                          .pagingController,
                      builderDelegate: PagedChildBuilderDelegate<Book>(
                        itemBuilder: (context, item, index) =>
                            BookCardItem(catListKey: GlobalKey(), book: item),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
