import 'package:search_page/search_page.dart';

import '../../../../books/presentation/widgets/book_card_item.dart';
import '../../domain/entities/favorite_book.dart';
import '../bloc/my_favorites_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/pagination/pagination_list_widget.dart';
import '../../../../../core/widgets/pagination/pagination_status_widget.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold_with_pagination.dart';

class MyFavoriteScreen extends StatelessWidget {
  const MyFavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    return CustomScaffoldPagination(
      scrollController: scrollController,
      title: "my_favorites",
      fetch: (bookLevel, isRefresh) => context
          .read<MyFavoritesBloc>()
          .add(FetchMyFavorites(isRefresh: isRefresh)),
      actions: [
        BlocBuilder<MyFavoritesBloc, MyFavoritesState>(
          builder: (context, state) {
            if (state.books.isEmpty) {
              return const SizedBox.shrink();
            }
            return IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchPage<FavoriteBook>(
                    items: state.books,
                    searchLabel: 'Search Assignment',
                    suggestion: const Center(
                      child: Text('Filter Assignments by title'),
                    ),
                    failure: const Center(
                      child: Text('No Assignments found :('),
                    ),
                    filter: (books) => [
                      books.title,
                    ],
                    builder: (book) => BookCardItem(book: book),
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
      builder: BlocBuilder<MyFavoritesBloc, MyFavoritesState>(
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
