import 'package:search_page/search_page.dart';

import '../../../../../core/entities/assignment/student_assignment.dart';
import '../bloc/my_assignments_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/pagination/pagination_list_widget.dart';
import '../../../../../core/widgets/pagination/pagination_status_widget.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold_with_pagination.dart';
import '../widgets/assignment_card_items.dart';

class StudentMyAssignmentsScreen extends StatelessWidget {
  const StudentMyAssignmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    return CustomScaffoldPagination(
      scrollController: scrollController,
      title: "my_assignments",
      fetch: (bookLevel, isRefresh) => context
          .read<MyAssignmentsBloc>()
          .add(FetchMyAssignments(isRefresh: isRefresh)),
      actions: [
        BlocBuilder<MyAssignmentsBloc, MyAssignmentsState>(
          builder: (context, state) {
            if (state.assignments.isEmpty) {
              return const SizedBox.shrink();
            }
            return IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchPage<StudentAssignment>(
                    items: state.assignments,
                    searchLabel: 'Search Assignment',
                    suggestion: const Center(
                      child: Text('Filter Assignments by title'),
                    ),
                    failure: const Center(
                      child: Text('No Assignments found :('),
                    ),
                    filter: (assignments) => [
                      assignments.assignmentArabicName,
                      assignments.assignmentEnglishName,
                    ],
                    builder: (assignment) =>
                        AssignmentCardItem(assignment: assignment),
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
      builder: BlocBuilder<MyAssignmentsBloc, MyAssignmentsState>(
        builder: (context, state) {
          return LoadingStatusWidget(
            errorMessage: state.errorMessage,
            requestStatus: state.status,
            widget: PaginationListWidget(
              scrollController: scrollController,
              items: state.assignments,
              child: (assignment) => AssignmentCardItem(assignment: assignment),
              hasReachedMax: state.hasReachedMax,
            ),
          );
        },
      ),
    );
  }
}
