import 'dart:async';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:library_app/core/resources/values_manager.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/entities/book/book.dart';
import '../../../../core/resources/app_localization.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/widgets/loading/list_shimmer_loading.dart';
import '../../../../core/widgets/loading/refresh_indicator.dart';
import '../../../../core/widgets/text/empty_widget.dart';
import '../../domain/enum/book_level.dart';
import '../cubit/book_selection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../bloc/books_bloc.dart';
import 'basic_book_details_widget.dart';
import 'book_assignment_widget.dart';
import 'book_levels_list.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

class BooksItemsListWidget extends StatefulWidget {
  const BooksItemsListWidget({super.key});

  @override
  State<BooksItemsListWidget> createState() => _BooksItemsListWidgetState();
}

class _BooksItemsListWidgetState extends State<BooksItemsListWidget> {
  bool showBookDetails = false;
  Book? book;
  bool isSelectItem = false;
  Map<int, bool> selectedItem = {};
  @override
  void initState() {
    BlocProvider.of<BooksBloc>(context)
        .pagingController
        .addPageRequestListener((pageKey) {
      BlocProvider.of<BooksBloc>(context).add(FetchBooks());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyRefreshIndicator(
      onRefresh: () {
        final Completer<void> completer = Completer<void>();

        BlocProvider.of<BooksBloc>(context).add(FetchBooks());
        completer.complete();
        return completer.future;
      },
      widget: Column(
        children: [
          SizedBox(
              height: AppSize.s50.h,
              child: BookLevelList(
                onLevelSelected: (level) {
                  BlocProvider.of<BooksBloc>(context)
                      .add(FetchBooks(bookLevel: level));
                },
              )),
          BlocConsumer<BooksBloc, BooksState>(
            listener: (context, state) {
              if (state is GetBooksLoading) {
                context.loaderOverlay.show();
              }
              if (state is GetBooksError) {
                context.loaderOverlay.hide();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
              if (state is GetBooksLoaded) {
                context.loaderOverlay.hide();
              }
            },
            builder: (context, state) {
              if (state is GetBooksLoading) {
                return const ListShimmerLoadingWidget();
              }
              if (state is GetBooksLoaded) {
                if (state.books.data.isEmpty) {
                  return const EmptyWidget();
                }
              }

              return Expanded(
                child: PagedListView<int, Book>(
                  pagingController:
                      BlocProvider.of<BooksBloc>(context).pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Book>(
                      itemBuilder: (context, item, index) {
                    book = item;
                    return BookAssignmentWidget(
                      book: book!,
                    );
                  }),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
