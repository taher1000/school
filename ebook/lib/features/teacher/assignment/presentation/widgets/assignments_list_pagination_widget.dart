import 'package:ebook/core/widgets/loading/pagination_widget.dart';
import 'package:ebook/features/teacher/assignment/domain/entities/assignment.dart';
import 'package:ebook/features/teacher/assignment/presentation/bloc/assignment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/loading/shimmer_loading.dart';
import '../../../../../core/widgets/text/custom_error_widget.dart';
import '../../../../../core/widgets/text/empty_widget.dart';

class AssignmentsPaginationWidget<t> extends StatelessWidget {
  final Function() loadMore;
  final Widget Function(t p) child;
  final Widget? onLoadMoreError;
  final Widget? onLoadMoreLoading;
  const AssignmentsPaginationWidget(
      {Key? key,
      required this.loadMore,
      this.onLoadMoreError,
      this.onLoadMoreLoading,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssignmentBloc, AssignmentState>(
      builder: (context, state) {
        if (state is GetAssignmentsLoaded) {
          List<Assignment> assignments =
              List<Assignment>.from(state.assignments.data!);
          return PaginationWidget<ScrollEndNotification>(
            isError: state.error != null,
            isLoading: state.loading != null,
            items: assignments,
            isLastPage: state.assignments.isLastPage ?? true,
            itemBuilder: (context, index) => child(assignments[index] as t),
            loadMore: () => BlocProvider.of<AssignmentBloc>(context)
                .add(FetchAssignments()),
            onLoadMoreError: onLoadMoreError,
            onLoadMoreLoading: onLoadMoreLoading,
          );
        }
        if (state is GetAssignmentsLoading) {
          return const ShimmerLoadingWidget();
        }
        if (state is GetAssignmentsEmpty) {
          return const EmptyWidget(text: "No Assignments available");
        }
        if (state is GetAssignmentsError) {
          return const CustomErrorWidget();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
