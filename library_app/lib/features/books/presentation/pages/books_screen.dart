import 'package:search_page/search_page.dart';

import '../../../../core/entities/book/book.dart';
import '../../../../core/widgets/pagination/pagination_list_widget.dart';
import '../../../../core/widgets/pagination/pagination_status_widget.dart';
import '../../../../core/widgets/scaffolds/custom_scaffold_with_pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/books_bloc.dart';
import '../widgets/teacher_book_item.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    return BlocBuilder<BooksBloc, BooksState>(builder: (context, state) {
      return CustomScaffoldPagination(
        hasSearch: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchPage<Book>(
                  items: state.books,
                  searchLabel: 'Search Books',
                  suggestion: const Center(
                    child: Text('Filter Books by title'),
                  ),
                  failure: const Center(
                    child: Text('No Books found :('),
                  ),
                  filter: (books) => [
                    books.title,
                  ],
                  builder: (book) => TeacherBookCardItem(
                    book: book,
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          )
        ],
        onSubmittedSearch: (searchValue) => context
            .read<BooksBloc>()
            .add(FetchBooks(isRefresh: true, search: searchValue)),
        hasBookLevels: true,
        scrollController: scrollController,
        title: "books",
        fetch: (bookLevel, isRefresh) => context
            .read<BooksBloc>()
            .add(FetchBooks(bookLevel: bookLevel, isRefresh: isRefresh)),
        builder: BlocBuilder<BooksBloc, BooksState>(
          builder: (context, state) {
            return LoadingStatusWidget(
              errorMessage: state.errorMessage,
              requestStatus: state.status,
              widget: PaginationListWidget(
                scrollController: scrollController,
                items: state.books,
                child: (book) => TeacherBookCardItem(
                  book: book!,
                ),
                hasReachedMax: state.hasReachedMax,
              ),
            );
          },
        ),
      );
    });
  }
}
