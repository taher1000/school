import 'package:ebook/core/widgets/scaffolds/custom_scaffold.dart';
import 'package:ebook/features/teacher_features/assignment/presentation/bloc/assignment_bloc.dart';
import 'package:ebook/features/teacher_features/assignment/presentation/pages/assignments_list_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/app_localization.dart';

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
      if (pageKey > 1) {
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
        body: const AssignmentsListBodyWidget());
  }
}
