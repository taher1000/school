import 'dart:async';

import 'package:ebook/core/navigation/custom_navigation.dart';
import 'package:ebook/core/resources/routes_manager.dart';
import 'package:ebook/features/teacher_features/assignment/presentation/widgets/assignment_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/widgets/loading/list_shimmer_loading.dart';
import '../../../../../core/widgets/loading/refresh_indicator.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';
import '../../../../../core/widgets/text/empty_widget.dart';
import '../../../../../injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/resources/app_localization.dart';
import '../../../../../core/entities/assignment/teacher_assignment.dart';
import '../bloc/assignment_bloc.dart';
import '../widgets/assignments_list_pagination_widget.dart';

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
      BlocProvider.of<AssignmentBloc>(context).add(const FetchAssignments());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      canPop: false,
      screenTitle:
          AppLocalization.of(context).getTranslatedValues("my_assignments")!,
      body: MyRefreshIndicator(
        onRefresh: () {
          final Completer<void> completer = Completer<void>();

          BlocProvider.of<AssignmentBloc>(context)
              .add(const FetchAssignments());

          completer.complete();

          return completer.future;
        },
        widget: BlocConsumer<AssignmentBloc, AssignmentState>(
          listener: (context, state) {
            if (state is GetAssignmentsLoading) {
              context.loaderOverlay.show();
            }
            if (state is GetAssignmentsError) {
              context.loaderOverlay.hide();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
            if (state is GetAssignmentsLoaded) {
              context.loaderOverlay.hide();
            }
          },
          builder: (context, state) {
            if (state is GetAssignmentsLoading) {
              return const ListShimmerLoadingWidget();
            }
            if (state is GetAssignmentsLoaded) {
              if (state.assignments.data.isEmpty) {
                return const EmptyWidget();
              }
            }
            return Expanded(
                child: PagedListView<int, TeacherAssignment>(
                    pagingController: BlocProvider.of<AssignmentBloc>(context)
                        .pagingController,
                    builderDelegate:
                        PagedChildBuilderDelegate<TeacherAssignment>(
                      itemBuilder: (context, item, index) =>
                          AssignmentItem(assignment: item),
                    )));
          },
        ),
      ),
    );
  }
}
