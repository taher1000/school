import 'dart:async';

import 'package:library_app/core/entities/book/book.dart';
import 'package:library_app/core/resources/color_manager.dart';
import 'package:library_app/core/resources/styles_manager.dart';
import 'package:library_app/core/widgets/loading/refresh_indicator.dart';
import 'package:library_app/core/widgets/popup/custom_snack_bar.dart';
import 'package:library_app/features/books/presentation/widgets/book_levels_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/constants.dart';
import '../../../../core/widgets/loading/list_shimmer_loading.dart';
import '../../../../core/widgets/scaffolds/custom_scaffold.dart';
import '../../../../core/widgets/text/empty_widget.dart';
import '../bloc/books_bloc.dart';
import '../widgets/book_card_item.dart';
import '../widgets/teacher_book_item.dart';

class BooksScreenBody extends StatelessWidget {
  const BooksScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BooksBloc>(context).add(FetchBooks());
    return MyRefreshIndicator(
      onRefresh: () {
        final Completer<void> completer = Completer<void>();
        BlocProvider.of<BooksBloc>(context).isRefresh = true;
        BlocProvider.of<BooksBloc>(context).add(FetchBooks());
        completer.complete();
        return completer.future;
      },
      widget: Column(
        children: [
          SizedBox(
            height: 50.h,
            child: BookLevelList(
              onLevelSelected: (level) {
                BlocProvider.of<BooksBloc>(context)
                    .add(FetchBooks(bookLevel: level));
              },
            ),
          ),
          BlocConsumer<BooksBloc, BooksState>(
            listener: (context, state) {
              if (state is GetBooksLoading) {
                context.loaderOverlay.show();
              }
              if (state is GetBooksError) {
                context.loaderOverlay.hide();
                showSnackBar(context,
                    message: state.message,
                    backgroundColor: ColorManager.error);
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
                    itemBuilder: (context, item, index) =>
                        TeacherBookCardItem(item),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
