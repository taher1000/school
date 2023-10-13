import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/resources/values_manager.dart';

import '../../../../core/entities/book/book.dart';
import '../../../../core/widgets/loading/refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/pagination/pagination_list_widget.dart';
import '../../../../core/widgets/pagination/pagination_status_widget.dart';
import '../bloc/books_bloc.dart';
import 'book_assignment_widget.dart';
import 'book_levels_list.dart';
import 'teacher_book_item.dart';

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
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    // BlocProvider.of<BooksBloc>(context)
    //     .pagingController
    //     .addPageRequestListener((pageKey) {
    BlocProvider.of<BooksBloc>(context).add(const FetchBooks());
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyRefreshIndicator(
      onRefresh: () {
        final Completer<void> completer = Completer<void>();

        BlocProvider.of<BooksBloc>(context).add(const FetchBooks());
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
              // if (state is GetBooksLoading) {
              //   context.loaderOverlay.show();
              // }
              // if (state is GetBooksError) {
              //   context.loaderOverlay.hide();
              //   showCustomSnackBar(context,
              //       message: state.message,
              //       backgroundColor: ColorManager.error);
              // }
              // if (state is GetBooksLoaded) {
              //   context.loaderOverlay.hide();
              // }
            },
            builder: (context, state) {
              // if (state is GetBooksLoading) {
              //   return const ListShimmerLoadingWidget();
              // }
              // if (state is GetBooksLoaded) {
              //   if (state.books.data.isEmpty) {
              //     return const EmptyWidget();
              //   }
              // }

              return BlocBuilder<BooksBloc, BooksState>(
                builder: (context, state) {
                  return LoadingStatusWidget(
                    errorMessage: state.errorMessage,
                    requestStatus: state.status,
                    widget: PaginationListWidget(
                      scrollController: scrollController,
                      items: state.books,
                      child: (book) => BookAssignmentWidget(
                        book: book!,
                      ),
                      hasReachedMax: state.hasReachedMax,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
