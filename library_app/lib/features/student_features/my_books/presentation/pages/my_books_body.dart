import 'dart:async';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/entities/book/book.dart';
import '../../../../../core/widgets/loading/list_shimmer_loading.dart';
import '../../../../../core/widgets/loading/refresh_indicator.dart';
import '../../../../../core/widgets/text/empty_widget.dart';
import '../../../../books/presentation/widgets/book_card_item.dart';
import '../bloc/my_books_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/widgets/popup/custom_snack_bar.dart';
import '../../../../books/presentation/widgets/book_levels_list.dart';

class MyBooksBody extends StatelessWidget {
  const MyBooksBody({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MyBooksBloc>(context).add(const FetchMyBooks());
    return MyRefreshIndicator(
      onRefresh: () {
        final Completer<void> completer = Completer<void>();
        BlocProvider.of<MyBooksBloc>(context).isRefresh = true;

        BlocProvider.of<MyBooksBloc>(context).add(const FetchMyBooks());
        completer.complete();
        return completer.future;
      },
      widget: Column(
        children: [
          SizedBox(
              height: 50.h,
              child: BookLevelList(
                onLevelSelected: (level) {
                  BlocProvider.of<MyBooksBloc>(context)
                      .add(FetchMyBooks(bookLevel: level));
                },
              )),
          BlocConsumer<MyBooksBloc, MyBooksState>(
            listener: (context, state) {
              if (state is GetMyBooksLoading) {
                context.loaderOverlay.show();
              }
              if (state is GetMyBooksError) {
                context.loaderOverlay.hide();
                showSnackBar(context,
                    message: state.message,
                    backgroundColor: ColorManager.error);
              }
              if (state is MyBooksLoaded) {
                context.loaderOverlay.hide();
              }
            },
            builder: (context, state) {
              if (state is GetMyBooksLoading) {
                return const ListShimmerLoadingWidget();
              }
              if (state is MyBooksLoaded) {
                if (state.books!.data.isEmpty) {
                  return const EmptyWidget();
                }
              }

              return Expanded(
                child: PagedListView<int, Book>(
                  pagingController:
                      BlocProvider.of<MyBooksBloc>(context).pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Book>(
                    itemBuilder: (context, item, index) =>
                        BookCardItem(book: item),
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
