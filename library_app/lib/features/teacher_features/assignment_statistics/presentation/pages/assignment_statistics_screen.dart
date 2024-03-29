import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/core/navigation/custom_navigation.dart';
import 'package:library_app/core/resources/routes_manager.dart';
import 'package:library_app/core/widgets/pagination/pagination_list_widget.dart';
import 'package:library_app/features/teacher_features/assignment_statistics/presentation/widgets/search_item.dart';
import 'package:search_page/search_page.dart';

import '../../../../../core/widgets/pagination/pagination_status_widget.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold_with_pagination.dart';
import '../../../../../core/widgets/search/simple_searchable_list_widget.dart';
import '../../domain/entities/assignment_statistics.dart';
import '../bloc/assignment_statistics_bloc.dart';

class AssignmentStatisticsScreen extends StatelessWidget {
  const AssignmentStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssignmentStatisticsBloc, AssignmentStatisticsState>(
        builder: (context, state) {
      return CustomScaffoldPagination(
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchPage<AssignmentStatistics>(
                  items: state.assignmentStatistics,
                  searchLabel: 'Search Students',
                  suggestion: const Center(
                    child: Text('Filter Students by name'),
                  ),
                  failure: const Center(
                    child: Text('No Students found :('),
                  ),
                  filter: (assignmentStatistics) => [
                    assignmentStatistics.studentEnglishName,
                    assignmentStatistics.studentArabicName,
                  ],
                  builder: (assignmentStatistics) => SearchItem(
                      assignmentStatistics: assignmentStatistics,
                      title: assignmentStatistics.studentEnglishName,
                      subTitle:
                          "Total Points: ${assignmentStatistics.totalPoints}",
                      onItemSelected: () {
                        CustomNavigator.push(
                            Routes.assignmentStatisticsDetailsRoute,
                            arguments: {
                              'assignmentStatistics': assignmentStatistics,
                            });
                      }),
                ),
              );
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          )
        ],
        hasPagination: false,
        title: "progress",
        fetch: (bookLevel, isRefresh) => context
            .read<AssignmentStatisticsBloc>()
            .add(const FetchAssignmentStatisticsEvent()),
        builder:
            BlocBuilder<AssignmentStatisticsBloc, AssignmentStatisticsState>(
          builder: (context, state) {
            return LoadingStatusWidget(
                errorMessage: state.errorMessage,
                requestStatus: state.status,
                widget: Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return SearchItem(
                        assignmentStatistics: state.assignmentStatistics[index],
                        onItemSelected: () {
                          CustomNavigator.push(
                              Routes.assignmentStatisticsDetailsRoute,
                              arguments: {
                                'assignmentStatistics':
                                    state.assignmentStatistics[index],
                              });
                        },
                        title: state
                            .assignmentStatistics[index].studentEnglishName,
                        subTitle:
                            "Total Points: ${state.assignmentStatistics[index].totalPoints}",
                      );
                    },
                    itemCount: state.assignmentStatistics.length,
                  ),
                ));
          },
        ),
      );
    });
  }
}

class DataSearch extends SearchDelegate<String> {
  final List<AssignmentStatistics> listExample;

  DataSearch(this.listExample);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? listExample
        : listExample
            .where((p) => p.studentEnglishName.startsWith(query))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          // TODO: Add your on tap action here
        },
        title: RichText(
          text: TextSpan(
            text: suggestionList[index]
                .studentEnglishName
                .substring(0, query.length),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: suggestionList[index]
                    .studentEnglishName
                    .substring(query.length),
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
