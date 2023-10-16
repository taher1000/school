import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../../../../../core/widgets/pagination/pagination_list_widget.dart';
import '../../../../../core/widgets/pagination/pagination_status_widget.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold_with_pagination.dart';
import '../bloc/assignment_statistics_bloc.dart';

class AssignmentStatisticsScreen extends StatefulWidget {
  const AssignmentStatisticsScreen({super.key});

  @override
  State<AssignmentStatisticsScreen> createState() =>
      _AssignmentStatisticsScreenState();
}

class _AssignmentStatisticsScreenState
    extends State<AssignmentStatisticsScreen> {
  final List<ChartData> chartData = [
    ChartData(1, 35),
    ChartData(2, 23),
    ChartData(3, 34),
    ChartData(4, 25),
    ChartData(5, 40)
  ];
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldPagination(
      hasBookLevels: true,
      scrollController: scrollController,
      title: "books",
      fetch: (bookLevel, isRefresh) => context
          .read<AssignmentStatisticsBloc>()
          .add(FetchAssignmentStatisticsEvent()),
      builder: BlocBuilder<AssignmentStatisticsBloc, AssignmentStatisticsState>(
        builder: (context, state) {
          return LoadingStatusWidget(
              errorMessage: state.errorMessage,
              requestStatus: state.status,
              widget: Expanded(
                child: Column(
                  children: [
                    SfCartesianChart(series: <ChartSeries<ChartData, int>>[
                      // Renders column chart
                      ColumnSeries<ChartData, int>(
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y)
                    ])
                  ],
                ),
              )
              // PaginationListWidget(
              //   scrollController: scrollController,
              //   items: state.assignmentStatistics,
              //   child: (assignmentStatistic) => ListTile(
              //     title: Text(assignmentStatistic!.title),
              //   ),
              //   hasReachedMax: state.hasReachedMax,
              // ),
              );
        },
      ),
    );
  }
}

class ChartData {
  ChartData(
    this.x,
    this.y,
  );
  final int x;
  final double y;
}
