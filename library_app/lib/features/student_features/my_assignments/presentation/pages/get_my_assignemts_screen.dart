import 'package:library_app/core/resources/app_localization.dart';
import 'package:library_app/features/student_features/my_assignments/presentation/bloc/my_assignments_bloc.dart';
import 'package:library_app/features/student_features/my_assignments/presentation/pages/my_assignments_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';

class StudentMyAssignmentsScreen extends StatefulWidget {
  final bool canPop;
  const StudentMyAssignmentsScreen({
    super.key,
    this.canPop = false,
  });

  @override
  State<StudentMyAssignmentsScreen> createState() =>
      _StudentMyAssignmentsScreenState();
}

class _StudentMyAssignmentsScreenState
    extends State<StudentMyAssignmentsScreen> {
  @override
  void initState() {
    BlocProvider.of<MyAssignmentsBloc>(context)
        .pagingController
        .addPageRequestListener((pageKey) {
      BlocProvider.of<MyAssignmentsBloc>(context)
          .add(const FetchMyAssignments());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      canPop: false,
      screenTitle:
          AppLocalization.of(context).getTranslatedValues("my_assignments"),
      body: const MyAssignmentsBodyWidget(),
    );
  }
}
