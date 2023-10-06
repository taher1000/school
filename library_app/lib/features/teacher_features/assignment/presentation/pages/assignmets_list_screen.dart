import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';
import '../bloc/assignment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/app_localization.dart';
import 'body/assignments_list_body.dart';

class AssignmentsListScreen extends StatefulWidget {
  const AssignmentsListScreen({super.key});

  @override
  State<AssignmentsListScreen> createState() => _AssignmentsListScreenState();
}

class _AssignmentsListScreenState extends State<AssignmentsListScreen> {
  @override
  void initState() {
    BlocProvider.of<AssignmentBloc>(context)
        .pagingController
        .addPageRequestListener((pageKey) {
      if (pageKey > 0) {
        BlocProvider.of<AssignmentBloc>(context).add(const FetchAssignments());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      canPop: false,
      screenTitle:
          AppLocalization.of(context).getTranslatedValues("my_assignments")!,
      body: const AssignmentsListBodyWidget(),
    );
  }
}
