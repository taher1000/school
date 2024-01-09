import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/core/navigation/custom_navigation.dart';
import 'package:library_app/core/resources/routes_manager.dart';
import 'package:library_app/features/teacher_features/assignment_statistics/presentation/widgets/search_item.dart';

import '../../../../../core/widgets/pagination/pagination_status_widget.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold_with_pagination.dart';
import '../../../../../core/widgets/search/simple_searchable_list_widget.dart';
import '../../domain/entities/assignment_statistics.dart';
import '../bloc/assignment_statistics_bloc.dart';

class AssignmentStatisticsScreen extends StatelessWidget {
  const AssignmentStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldPagination(
      hasPagination: false,
      title: "progress",
      fetch: (bookLevel, isRefresh) => context
          .read<AssignmentStatisticsBloc>()
          .add(const FetchAssignmentStatisticsEvent()),
      builder: BlocBuilder<AssignmentStatisticsBloc, AssignmentStatisticsState>(
        builder: (context, state) {
          return LoadingStatusWidget(
            errorMessage: state.errorMessage,
            requestStatus: state.status,
            widget: Container(
              height: 300,
              color: Colors.red,
              child: SimpleSearchableList(
                items: state.assignmentStatistics,
                onItemSelected: (dynamic item) {
                  item as AssignmentStatistics;
                  CustomNavigator.push(Routes.assignmentStatisticsDetailsRoute,
                      arguments: {
                        'assignmentStatistics': item,
                      });
                },
                filter: (val) {
                  return state.assignmentStatistics
                      .where(
                          (element) => element.studentEnglishName.contains(val))
                      .toList();
                },
                builder: (list, index, item) {
                  item as AssignmentStatistics;
                  return SearchItem(
                      title: item.studentEnglishName,
                      subTitle: item.studentArabicName);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
