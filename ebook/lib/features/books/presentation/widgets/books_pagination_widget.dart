import '../../../../core/widgets/loading/grid_pagination_widget.dart';
import '../../../../core/widgets/loading/list_shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading/grid_shimmer_loading.dart';
import '../../../../core/widgets/text/custom_error_widget.dart';
import '../../../../core/widgets/text/empty_widget.dart';
import '../../domain/entities/book.dart';
import '../bloc/books_bloc.dart';

class BooksPaginationWidget<t> extends StatelessWidget {
  final Function() loadMore;
  final Widget Function(t p) child;
  final Widget? onLoadMoreError;
  final Widget? onLoadMoreLoading;
  final bool isGrid;
  const BooksPaginationWidget(
      {Key? key,
      required this.loadMore,
      this.onLoadMoreError,
      this.onLoadMoreLoading,
      this.isGrid = true,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BooksBloc, BooksState>(
      builder: (context, state) {
        if (state is GetBooksLoaded) {
          List<Book> books = List<Book>.from(state.books.data!);
          return PaginationWidget<ScrollEndNotification>(
            isError: state.error != null,
            isLoading: state.loading != null,
            items: books,
            nextPage: state.books.nextPage!,
            itemBuilder: (context, index) => child(books[index] as t),
            loadMore: () =>
                BlocProvider.of<BooksBloc>(context).add(FetchBooks()),
            onLoadMoreError: onLoadMoreError,
            onLoadMoreLoading: onLoadMoreLoading,
          );
        }
        if (state is GetBooksLoading) {
          return isGrid
              ? const GridShimmerLoadingWidget()
              : const ListShimmerLoadingWidget();
        }
        if (state is GetBooksEmpty) {
          return const EmptyWidget(text: "No Books available");
        }
        if (state is GetBooksError) {
          return const CustomErrorWidget();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
