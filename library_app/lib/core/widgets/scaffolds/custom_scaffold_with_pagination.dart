import 'dart:async';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/loading/refresh_indicator.dart';
import 'package:flutter/material.dart';

import '../../../../../core/resources/app_localization.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';
import '../../../features/books/presentation/widgets/book_levels_list.dart';

class CustomScaffoldPagination extends StatefulWidget {
  final ScrollController scrollController;
  final Widget builder;
  final bool hasBookLevels;
  final String title;
  final void Function(int?, bool) fetch;

  const CustomScaffoldPagination(
      {super.key,
      required this.scrollController,
      required this.builder,
      required this.title,
      required this.fetch,
      this.hasBookLevels = false});

  @override
  State<CustomScaffoldPagination> createState() =>
      _CustomScaffoldPaginationState();
}

class _CustomScaffoldPaginationState extends State<CustomScaffoldPagination> {
  int? bookLevel;
  @override
  void initState() {
    super.initState();
    widget.fetch(bookLevel, false); //* for fetching first page
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = widget.scrollController.position.maxScrollExtent;
    final currentScroll = widget.scrollController.offset;

    if (currentScroll >= (maxScroll * 0.9)) {
      widget.fetch(bookLevel, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        canPop: false,
        screenTitle:
            AppLocalization.of(context).getTranslatedValues(widget.title),
        body: MyRefreshIndicator(
          onRefresh: () {
            final Completer<void> completer = Completer<void>();
            widget.fetch(bookLevel, true);
            completer.complete();
            return completer.future;
          },
          widget: Column(
            children: [
              if (widget.hasBookLevels)
                SizedBox(
                    height: 50.h,
                    child: BookLevelList(
                      onLevelSelected: (level) {
                        bookLevel = level;
                        widget.fetch(bookLevel, false);
                      },
                    )),
              widget.builder,
            ],
          ),
        )
        //const MyBooksBody()
        );
  }
}