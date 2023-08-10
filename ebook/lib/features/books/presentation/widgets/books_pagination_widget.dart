import 'package:ebook/core/widgets/loading/pagination_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/book.dart';
import '../bloc/books_bloc.dart';

class BooksPaginationWidget<t> extends StatelessWidget {
  final Function() loadMore;
  final Widget initialError;
  final Widget initialLoading;
  final Widget initialEmpty;
  final Widget Function(t p) child;
  final Widget? onLoadMoreError;
  final Widget? onLoadMoreLoading;
  const BooksPaginationWidget(
      {Key? key,
      required this.loadMore,
      required this.initialError,
      required this.initialLoading,
      required this.initialEmpty,
      this.onLoadMoreError,
      this.onLoadMoreLoading,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BooksBloc, BooksState>(
      builder: (context, state) {
        if (state is GetBooksLoaded) {
          List<Book> products = List<Book>.from(state.books.data!);
          return PaginationWidget<ScrollEndNotification>(
              onNotification: (scrollInfo) {
                scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent &&
                        !state.books.isLastPage!
                    ? loadMore()
                    : null;
                return true;
              },
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (context, index) =>
                              child(products[index] as t))),
                  const SizedBox(
                    height: 20,
                  ),
                  //if error occured while loading more
                  if (state.error != null)
                    Expanded(child: onLoadMoreError ?? initialError),
                  if (state.loading != null)
                    Expanded(child: onLoadMoreLoading ?? initialLoading),
                ],
              ));
        }
        if (state is GetBooksLoading) {
          return initialLoading;
        }
        if (state is GetBooksEmpty) {
          return initialEmpty;
        }
        if (state is GetBooksError) {
          return initialError;
        }
        return const SizedBox.shrink();
      },
    );
  }
}
