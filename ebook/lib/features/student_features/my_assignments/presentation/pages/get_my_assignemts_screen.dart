import 'package:ebook/core/resources/app_localization.dart';
import 'package:ebook/features/books/presentation/widgets/book_levels_list.dart';
import 'package:ebook/features/student_features/my_assignments/presentation/bloc/my_assignments_bloc.dart';
import 'package:ebook/features/student_features/my_assignments/presentation/widgets/my_assignments_grid_widget.dart';
import 'package:ebook/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';

class StudentMyAssignmentsScreen extends StatelessWidget {
  final bool canPop;
  const StudentMyAssignmentsScreen({
    super.key,
    this.canPop = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      screenTitle:
          AppLocalization.of(context).getTranslatedValues("my_assignments")!,
      canPop: canPop,
      body: Column(
        children: [
          SizedBox(height: 40.h, child: const BookLevelList()),
          const StudentMyAssignmentItemsGridWidget()
        ],
      ),
    );
  }
}
