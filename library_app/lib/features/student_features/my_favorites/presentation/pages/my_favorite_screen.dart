import '../../../../books/presentation/widgets/book_card_item.dart';
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
      builder: BlocBuilder<MyFavoritesBloc, MyFavoritesState>(
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
