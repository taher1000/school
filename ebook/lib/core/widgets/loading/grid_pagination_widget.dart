import 'package:flutter/material.dart';

import '../text/custom_error_widget.dart';
import 'grid_shimmer_loading.dart';

class PaginationWidget<t> extends StatelessWidget {
  final Function() loadMore;

  final Widget? onLoadMoreError;
  final Widget? onLoadMoreLoading;
  final bool isError;
  final bool isLoading;
  final List<Object> items;
  final bool nextPage;
  final Widget? Function(BuildContext, int) itemBuilder;
  const PaginationWidget(
      {Key? key,
      required this.loadMore,
      this.onLoadMoreError,
      this.onLoadMoreLoading,
      // required this.child,
      required this.isError,
      required this.isLoading,
      required this.items,
      required this.nextPage,
      required this.itemBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollEndNotification>(
        onNotification: (scrollInfo) {
          scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                  nextPage
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
            if (isError)
              Expanded(child: onLoadMoreError ?? const CustomErrorWidget()),
            if (isLoading)
              Expanded(
                  child: onLoadMoreLoading ?? const GridShimmerLoadingWidget()),
          ],
        ));
  }
}
