import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';

import '../../../../../core/widgets/pagination/pagination_list_widget.dart';
import '../../../../../core/widgets/pagination/pagination_status_widget.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold_with_pagination.dart';
import '../bloc/assignment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/assignment_item.dart';

class AssignmentsListScreen extends StatelessWidget {
  const AssignmentsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final controller = IndicatorController();
    return CustomScaffoldPagination(
      scrollController: scrollController,
      title: "my_assignments",
      fetch: (bookLevel, isRefresh) => context
          .read<AssignmentBloc>()
          .add(FetchAssignments(isRefresh: isRefresh)),
      builder: BlocBuilder<AssignmentBloc, AssignmentState>(
        builder: (context, state) {
          return LoadingStatusWidget(
            errorMessage: state.errorMessage,
            requestStatus: state.status,
            widget: PaginationListWidget(
              scrollController: scrollController,
              items: state.assignments,
              child: (assignment) => AssignmentItem(
                assignment: assignment,
                controller: controller,
              ),
              hasReachedMax: state.hasReachedMax,
            ),
          );
        },
      ),
    );
  }
}
