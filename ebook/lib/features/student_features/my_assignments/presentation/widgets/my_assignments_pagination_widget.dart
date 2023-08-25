import 'package:ebook/features/student_features/my_assignments/presentation/bloc/my_assignments_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/entities/book/book.dart';
import '../../../../../core/widgets/loading/grid_pagination_widget.dart';
import '../../../../../core/widgets/loading/grid_shimmer_loading.dart';
import '../../../../../core/widgets/loading/list_shimmer_loading.dart';
import '../../../../../core/widgets/text/custom_error_widget.dart';
import '../../../../../core/widgets/text/empty_widget.dart';

class MyAssignmentsPaginationWidget<t> extends StatelessWidget {
  final Function() loadMore;
  final Widget Function(t p) child;
  final Widget? onLoadMoreError;
  final Widget? onLoadMoreLoading;
  final bool isGrid;
  const MyAssignmentsPaginationWidget(
      {Key? key,
      required this.loadMore,
      this.onLoadMoreError,
      this.onLoadMoreLoading,
      this.isGrid = true,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyAssignmentsBloc, MyAssignmentsState>(
      builder: (context, state) {
        if (state is GetMyAssignmentsLoaded) {
          List<Book> books = List<Book>.from(state.assignments.data);
          if (books.isEmpty) {
            return const EmptyWidget(text: "No Books available");
          }
          return PaginationWidget<ScrollEndNotification>(
            isError: state.error != null,
            isLoading: state.loading != null,
            items: books,
            nextPage: state.assignments.nextPage!,
            itemBuilder: (context, index) => child(books[index] as t),
            loadMore: () => BlocProvider.of<MyAssignmentsBloc>(context)
                .add(FetchMyAssignments()),
            onLoadMoreError: onLoadMoreError,
            onLoadMoreLoading: onLoadMoreLoading,
          );
        }
        if (state is GetMyAssignmentsLoading) {
          return isGrid
              ? const GridShimmerLoadingWidget()
              : const ListShimmerLoadingWidget();
        }
        if (state is GetMyAssignmentsEmpty) {
          return const EmptyWidget(text: "No Assignments available");
        }
        if (state is GetMyAssignmentsError) {
          return const CustomErrorWidget();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
