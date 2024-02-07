import 'package:library_app/core/entities/book/book.dart';
import 'package:library_app/core/resources/color_manager.dart';
import 'package:library_app/core/resources/styles_manager.dart';
import 'package:library_app/injection_container.dart';
import 'package:search_page/search_page.dart';

import '../../../../../core/resources/font_manager.dart';
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
    return CustomScaffoldPagination(
      hasBookLevels: true,
      scrollController: scrollController,
      title: "my_books",
      centerTitle: true,
      fetch: (bookLevel, isRefresh) => context
          .read<MyBooksBloc>()
          .add(FetchMyBooks(bookLevel: bookLevel, isRefresh: isRefresh)),
      actions: [
        Column(
          children: [
            const Spacer(flex: 1),
            Text(
              "Name: ${sharedPrefsClient.currentLanguage == 'en' ? sharedPrefsClient.englishFullName.split(" ")[0] : sharedPrefsClient.arabicFullName.split(" ")[0]} ",
              overflow: TextOverflow.ellipsis,
              style: TextStyleManager.getMediumStyle(
                  color: ColorManager.white, fontSize: FontSize.s18),
            ),
            Text(
              sharedPrefsClient.email,
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyleManager.getRegularStyle(color: ColorManager.white),
            ),
            const Spacer(flex: 1),
          ],
        ),
        BlocBuilder<MyBooksBloc, MyBooksState>(
          builder: (context, state) {
            return IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchPage<Book>(
                    items: state.books,
                    searchLabel: 'Search Book',
                    suggestion: const Center(
                      child: Text('Filter Books by title'),
                    ),
                    failure: const Center(
                      child: Text('No Books found :('),
                    ),
                    filter: (books) => [
                      books.title,
                    ],
                    builder: (book) => BookCardItem(
                      book: book,
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            );
          },
        )
      ],
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
