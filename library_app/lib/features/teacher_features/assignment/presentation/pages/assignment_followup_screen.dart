import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/pagination/pagination_list_widget.dart';
import '../../../../../core/widgets/pagination/pagination_status_widget.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold_with_pagination.dart';
import '../widgets/follow_up_assignment_item_widget.dart';
import 'package:flutter/material.dart';
import '../bloc/follow_up_assignments_students_bloc/follow_up_assignments_students_bloc.dart';

class AssignmentFollowUpScreen extends StatelessWidget {
  const AssignmentFollowUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    return CustomScaffoldPagination(
      scrollController: scrollController,
      title: "follow_assignment",
      fetch: (bookLevel, isRefresh) => context
          .read<FollowUpAssignmentsStudentsBloc>()
          .add(FetchFollowUpAssignments(isRefresh: isRefresh)),
      builder: BlocBuilder<FollowUpAssignmentsStudentsBloc,
          FollowUpAssignmentsStudentsState>(
        builder: (context, state) {
          return LoadingStatusWidget(
            errorMessage: state.errorMessage,
            requestStatus: state.status,
            widget: PaginationListWidget(
              scrollController: scrollController,
              items: state.assignments,
              child: (assignment) => FollowUpAssignmentItemWidget(
                item: assignment,
              ),
              hasReachedMax: state.hasReachedMax,
            ),
          );
        },
      ),
    );
  }
}
