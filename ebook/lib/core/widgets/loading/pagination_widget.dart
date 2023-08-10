import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/books/domain/entities/book.dart';
import '../../../features/books/presentation/bloc/books_bloc.dart';

class PaginationWidget<t> extends StatelessWidget {
  final Function() loadMore;
  final Widget initialError;
  final Widget initialLoading;
  final Widget initialEmpty;
  // final Widget Function(t p) child;
  final Widget? onLoadMoreError;
  final Widget? onLoadMoreLoading;
  final bool isError;
  final bool isLoading;
  final List<Object> items;
  final bool isLastPage;
  final Widget? Function(BuildContext, int) itemBuilder;
  const PaginationWidget(
      {Key? key,
      required this.loadMore,
      required this.initialError,
      required this.initialLoading,
      required this.initialEmpty,
      this.onLoadMoreError,
      this.onLoadMoreLoading,
      // required this.child,
      required this.isError,
      required this.isLoading,
      required this.items,
      required this.isLastPage,
      required this.itemBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollEndNotification>(
        onNotification: (scrollInfo) {
          scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                  !isLastPage
              ? loadMore()
              : null;
          return true;
        },
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: items.length, itemBuilder: itemBuilder)),
            const SizedBox(
              height: 20,
            ),
            //if error occured while loading more
            if (isError) Expanded(child: onLoadMoreError ?? initialError),
            if (isLoading) Expanded(child: onLoadMoreLoading ?? initialLoading),
          ],
        ));
  }
}
