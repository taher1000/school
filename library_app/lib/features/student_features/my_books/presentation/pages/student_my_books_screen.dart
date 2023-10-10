import 'dart:async';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/core/widgets/popup/custom_snack_bar.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../core/enums/request_status.dart';
import '../../../../../core/widgets/loading/circular_progress_loader.dart';
import '../../../../../core/widgets/loading/refresh_indicator.dart';
import '../../../../../core/widgets/pagination/pagination_list_widget.dart';
import '../../../../../core/widgets/pagination/pagination_status_widget.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold_with_pagination.dart';
import '../../../../../core/widgets/text/empty_widget.dart';
import '../../../../books/presentation/widgets/book_card_item.dart';
import '../../../../books/presentation/widgets/book_levels_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/app_localization.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';
import '../bloc/my_books_bloc.dart';

class StudentMyBooksScreen extends StatelessWidget {
  const StudentMyBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    return CustomScaffoldPagination(
      hasBookLevels: true,
      scrollController: scrollController,
      title: "my_books",
      fetch: (bookLevel, isRefresh) => context
          .read<MyBooksBloc>()
          .add(FetchMyBooks(bookLevel: bookLevel, isRefresh: isRefresh)),
      builder: BlocBuilder<MyBooksBloc, MyBooksState>(
        builder: (context, state) {
          return PaginationStatusWidget(
            errorMessage: state.errorMessage,
            state: state.status,
            widget: PaginationListWidget(
              scrollController: scrollController,
              items: state.books,
              child: (book) => BookCardItem(book: book),
              hasReachedMax: state.hasReachedMax,
            ),
          );
        },
      ),
    );
  }
}
