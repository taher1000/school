import 'package:flutter/material.dart';

import '../loading/circular_progress_loader.dart';

class PaginationListWidget extends StatelessWidget {
  final List items;
  final ScrollController scrollController;
  final bool hasReachedMax;
  final Widget Function(dynamic) child;

  const PaginationListWidget(
      {super.key,
      required this.items,
      required this.scrollController,
      required this.hasReachedMax,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: hasReachedMax ? items.length : items.length + 1,
        controller: scrollController,
        itemBuilder: (context, index) {
          return index >= items.length
              ? const CustomLoader()
              : child(items[index]);
        },
      ),
    );
  }
}
