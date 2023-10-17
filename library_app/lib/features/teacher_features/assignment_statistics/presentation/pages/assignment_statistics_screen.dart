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
    ChartData('China', 12, 10, 14, 20),
    ChartData('USA', 14, 11, 18, 23),
    ChartData('UK', 16, 10, 15, 20),
    ChartData('Brazil', 18, 16, 18, 24)
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
                    SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        series: <ChartSeries>[
                          StackedColumnSeries<ChartData, String>(
                              dataSource: chartData,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y1),
                          StackedColumnSeries<ChartData, String>(
                              dataSource: chartData,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y2),
                          StackedColumnSeries<ChartData, String>(
                              dataSource: chartData,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y3),
                          StackedColumnSeries<ChartData, String>(
                              dataSource: chartData,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y4)
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
  ChartData(this.x, this.y1, this.y2, this.y3, this.y4);
  final String x;
  final int y1;
  final int y2;
  final int y3;
  final int y4;
}
