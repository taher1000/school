import 'dart:async';

import 'package:ebook/core/entities/book/book.dart';
import 'package:ebook/core/resources/app_localization.dart';
import 'package:ebook/core/widgets/loading/list_shimmer_loading.dart';
import 'package:ebook/core/widgets/loading/refresh_indicator.dart';
import 'package:ebook/features/books/presentation/widgets/book_levels_list.dart';
import 'package:ebook/features/student_features/my_assignments/presentation/bloc/my_assignments_bloc.dart';
import 'package:ebook/features/student_features/my_assignments/presentation/pages/my_assignments_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';
import '../../../../../core/widgets/text/empty_widget.dart';
import '../../../../books/presentation/widgets/book_card_item.dart';

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
            AppLocalization.of(context).getTranslatedValues("my_assignments")!,
        body: const MyAssignmentsBodyWidget());
  }
}
