// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../../core/entities/book/book.dart';
// import '../../../../../core/widgets/loading/grid_pagination_widget.dart';
// import '../../../../../core/widgets/loading/grid_shimmer_loading.dart';
// import '../../../../../core/widgets/loading/list_shimmer_loading.dart';
// import '../../../../../core/widgets/text/custom_error_widget.dart';
// import '../../../../../core/widgets/text/empty_widget.dart';
// import '../bloc/my_books_bloc.dart';

// class MyBooksPaginationWidget<t> extends StatelessWidget {
//   final Function() loadMore;
//   final Widget Function(t p) child;
//   final Widget? onLoadMoreError;
//   final Widget? onLoadMoreLoading;
//   final bool isGrid;
//   const MyBooksPaginationWidget(
//       {Key? key,
//       required this.loadMore,
//       this.onLoadMoreError,
//       this.onLoadMoreLoading,
//       this.isGrid = true,
//       required this.child})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<MyBooksBloc, MyBooksState>(
//       builder: (context, state) {
//         if (state is GetMyBooksLoaded) {
//           List<Book> books = List<Book>.from(state.books.data);
//           if (books.isEmpty) {
//             return const EmptyWidget(text: "No Books available");
//           }
//           return PaginationWidget<ScrollEndNotification>(
//             isError: state.error != null,
//             isLoading: state.loading != null,
//             items: books,
//             nextPage: state.books.nextPage!,
//             itemBuilder: (context, index) => child(books[index] as t),
//             loadMore: () =>
//                 BlocProvider.of<MyBooksBloc>(context).add(FetchMyBooks()),
//             onLoadMoreError: onLoadMoreError,
//             onLoadMoreLoading: onLoadMoreLoading,
//           );
//         }
//         if (state is GetMyBooksLoading) {
//           return isGrid
//               ? const GridShimmerLoadingWidget()
//               : const ListShimmerLoadingWidget();
//         }
//         if (state is GetMyBooksEmpty) {
//           return const EmptyWidget(text: "No Books available");
//         }
//         if (state is GetMyBooksError) {
//           return const CustomErrorWidget();
//         }
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }
