import '../../../../../core/widgets/pagination/pagination_list_widget.dart';
import '../../../../../core/widgets/pagination/pagination_status_widget.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold_with_pagination.dart';
import '../../../../books/presentation/widgets/book_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/my_books_bloc.dart';

class StudentMyBooksScreen extends StatefulWidget {
  const StudentMyBooksScreen({super.key});

  @override
  State<StudentMyBooksScreen> createState() => _StudentMyBooksScreenState();
}

class _StudentMyBooksScreenState extends State<StudentMyBooksScreen> {
  String searchText = '';
  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    print("habi is $searchText");
    return CustomScaffoldPagination(
      hasBookLevels: true,
      hasSearch: true,
      clearSearch: searchText.isNotEmpty,
      onSubmittedSearch: (searchValue) {
        setState(() {
          searchText = searchValue;
        });
        print("habi is $searchText");
        return context
            .read<MyBooksBloc>()
            .add(FetchMyBooks(isRefresh: true, search: searchValue));
      },
      scrollController: scrollController,
      title: "my_books",
      fetch: (bookLevel, isRefresh) => context
          .read<MyBooksBloc>()
          .add(FetchMyBooks(bookLevel: bookLevel, isRefresh: isRefresh)),
      fetchAfterClearSearch: (bookLevel, isRefresh) {
        setState(() {
          searchText = '';
        });
        return context
            .read<MyBooksBloc>()
            .add(FetchMyBooks(bookLevel: bookLevel, isRefresh: isRefresh));
      },
      builder: BlocBuilder<MyBooksBloc, MyBooksState>(
        builder: (context, state) {
          return LoadingStatusWidget(
            errorMessage: state.errorMessage,
            requestStatus: state.status,
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
