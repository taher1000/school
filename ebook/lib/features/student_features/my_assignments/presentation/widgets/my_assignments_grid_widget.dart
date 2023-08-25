import 'package:ebook/core/entities/assignment/student_assignment.dart';
import 'package:ebook/features/student_features/my_assignments/presentation/bloc/my_assignments_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../books/presentation/widgets/book_card_item.dart';
import 'my_assignments_pagination_widget.dart';

class StudentMyAssignmentItemsGridWidget extends StatefulWidget {
  const StudentMyAssignmentItemsGridWidget({super.key});

  @override
  State<StudentMyAssignmentItemsGridWidget> createState() =>
      _StudentMyAssignmentItemsGridWidgetState();
}

class _StudentMyAssignmentItemsGridWidgetState
    extends State<StudentMyAssignmentItemsGridWidget> {
  @override
  void initState() {
    BlocProvider.of<MyAssignmentsBloc>(context).add(FetchMyAssignments());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MyAssignmentsPaginationWidget<StudentAssignment>(
        loadMore: () {
          BlocProvider.of<MyAssignmentsBloc>(context).add(FetchMyAssignments());
        },
        child: (StudentAssignment assignment) {
          return BookCardItem(catListKey: GlobalKey(), book: assignment);
        },
      ),
    );
  }
}
