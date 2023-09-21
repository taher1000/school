import 'dart:async';

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:library_app/core/navigation/custom_navigation.dart';
import 'package:library_app/core/resources/routes_manager.dart';
import 'package:library_app/features/teacher_features/assignment/presentation/bloc/delete_assignment/delete_assignment_cubit.dart';
import 'package:library_app/features/teacher_features/assignment/presentation/widgets/assignment_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/font_manager.dart';
import '../../../../../../core/resources/styles_manager.dart';
import '../../../../../../core/widgets/loading/list_shimmer_loading.dart';
import '../../../../../../core/widgets/loading/refresh_indicator.dart';
import '../../../../../../core/widgets/scaffolds/custom_scaffold.dart';
import '../../../../../../core/widgets/text/empty_widget.dart';
import '../../../../../../injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../core/resources/app_localization.dart';
import '../../../../../../core/entities/assignment/teacher_assignment.dart';
import '../../bloc/assignment_bloc.dart';
import '../../widgets/assignments_list_pagination_widget.dart';

class AssignmentsListBodyWidget extends StatelessWidget {
  const AssignmentsListBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AssignmentBloc>(context).add(const FetchAssignments());
    final controller = IndicatorController();
    return MyRefreshIndicator(
      controller: controller,
      onRefresh: () {
        final Completer<void> completer = Completer<void>();
        BlocProvider.of<AssignmentBloc>(context).isRefresh = true;

        BlocProvider.of<AssignmentBloc>(context).add(const FetchAssignments());

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
          return BlocListener<DeleteAssignmentCubit, DeleteAssignmentState>(
              listener: (context, state) {
                if (state is DeleteAssignmentLoading) {
                  context.loaderOverlay.show();
                }
                if (state is DeleteAssignmentFailure) {
                  context.loaderOverlay.hide();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
                if (state is DeleteAssignmentSuccess) {
                  context.loaderOverlay.hide();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
              child: Expanded(
                  child: PagedListView<int, TeacherAssignment>(
                      pagingController: BlocProvider.of<AssignmentBloc>(context)
                          .pagingController,
                      builderDelegate:
                          PagedChildBuilderDelegate<TeacherAssignment>(
                        itemBuilder: (context, item, index) => AssignmentItem(
                            assignment: item, controller: controller),
                      ))));
        },
      ),
    );
  }
}
