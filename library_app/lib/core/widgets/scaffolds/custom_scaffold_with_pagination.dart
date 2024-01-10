import 'dart:async';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/loading/refresh_indicator.dart';
import 'package:flutter/material.dart';

import '../../../../../core/resources/app_localization.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';
import '../../../features/books/presentation/widgets/book_levels_list.dart';

class CustomScaffoldPagination extends StatefulWidget {
  final ScrollController? scrollController;
  final Widget builder;
  final bool hasBookLevels;
  final bool hasSearch;
  final String title;
  final void Function(int?, bool) fetch;
  final void Function(int?, bool)? fetchAfterClearSearch;
  final bool hasPagination;
  final dynamic Function(String)? onSubmittedSearch;
  final bool clearSearch;
  final List<Widget>? actions;
  const CustomScaffoldPagination(
      {super.key,
      this.scrollController,
      required this.builder,
      required this.title,
      this.hasSearch = false,
      required this.fetch,
      this.hasPagination = true,
      this.onSubmittedSearch,
      this.clearSearch = false,
      this.fetchAfterClearSearch,
      this.actions,
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
    if (widget.scrollController != null) {
      widget.scrollController?.addListener(_onScroll);
    }
  }

  @override
  void dispose() {
    if (widget.scrollController != null) {
      widget.scrollController!
        ..removeListener(_onScroll)
        ..dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    if (widget.scrollController == null) return;
    final maxScroll = widget.scrollController!.position.maxScrollExtent;
    final currentScroll = widget.scrollController!.offset;

    if (currentScroll >= (maxScroll * 0.9)) {
      widget.fetch(bookLevel, false);
    }
  }

  final TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      canPop: false,
      actions: widget.actions,

      screenTitle:
          AppLocalization.of(context).getTranslatedValues(widget.title),
      body: widget.hasPagination
          ? MyRefreshIndicator(
              onRefresh: () {
                final Completer<void> completer = Completer<void>();
                widget.fetch(null, true);
                completer.complete();
                return completer.future;
              },
              widget: Column(
                children: [
                  if (widget.hasBookLevels)
                    SizedBox(
                        height: 50.h,
                        child: BookLevelList(
                          onLevelSelected: onLevelSelected,
                        )),
                  widget.builder,
                ],
              ),
            )
          : Column(
              children: [
                if (widget.hasBookLevels)
                  SizedBox(
                      height: 50.h,
                      child: BookLevelList(
                        onLevelSelected: onLevelSelected,
                      )),
                widget.builder,
              ],
            ),
      //const MyBooksBody()
    );
  }

  onLevelSelected(int? level) {
    if (level == null) {
      widget.fetch(null, true);
      return;
    }
    bookLevel = level;
    widget.fetch(bookLevel, false);
    bookLevel = null;
  }
}
