import 'package:flutter_bloc/flutter_bloc.dart';
import 'body/follow_up_assignment_body.dart';

import '../../../../../core/resources/app_localization.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';
import 'package:flutter/material.dart';
import '../bloc/follow_up_assignments_students_bloc/follow_up_assignments_students_bloc.dart';

class AssignmentFollowUpScreen extends StatefulWidget {
  const AssignmentFollowUpScreen({super.key});

  @override
  State<AssignmentFollowUpScreen> createState() =>
      _AssignmentFollowUpScreenState();
}

class _AssignmentFollowUpScreenState extends State<AssignmentFollowUpScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FollowUpAssignmentsStudentsBloc>(context)
        .pagingController
        .addPageRequestListener((pageKey) {
      if (pageKey > 1) {
        BlocProvider.of<FollowUpAssignmentsStudentsBloc>(context)
            .add(const FetchFollowUpAssignments());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;
    return CustomScaffold(
      screenTitle: localize('follow_assignment'),
      body: const FollowUpAssignmentsListBodyWidget(),
    );
  }
}
