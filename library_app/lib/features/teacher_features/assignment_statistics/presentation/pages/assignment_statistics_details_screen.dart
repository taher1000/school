import 'package:flutter/material.dart';
import 'package:library_app/core/resources/color_manager.dart';
import 'package:library_app/core/widgets/scaffolds/custom_scaffold.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../domain/entities/assignment_statistics.dart';

class AssignmentStatisticsDetailsScreen extends StatelessWidget {
  final AssignmentStatistics assignmentStatistics;

  const AssignmentStatisticsDetailsScreen(
      {super.key, required this.assignmentStatistics});

  @override
  Widget build(BuildContext context) {
    final List<String> texts = [
      'Total Assignment',
      'Assignment Completed',
      'Assignment Remaining',
      'Total Points',
    ];
    final tooltip = TooltipBehavior(enable: true);

    return CustomScaffold(
        screenTitle: assignmentStatistics.studentEnglishName,
        body: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(minimum: 0, maximum: 15, interval: 1),
            tooltipBehavior: tooltip,
            series: <ChartSeries<AssignmentStatistics, String>>[
              _buildItem(
                texts[0],
                yValueMapper: (data, _) => data.assignment,
              ),
              _buildItem(
                texts[1],
                yValueMapper: (data, _) => data.assignmentCompleted,
              ),
              _buildItem(
                texts[2],
                yValueMapper: (data, _) => data.assignmentRemaining,
              ),
              _buildItem(
                texts[3],
                yValueMapper: (data, _) => data.totalPoints,
              ),
            ]));
  }

  ColumnSeries<AssignmentStatistics, String> _buildItem(String title,
      {required num? Function(AssignmentStatistics, int) yValueMapper}) {
    return ColumnSeries<AssignmentStatistics, String>(
        dataSource: [assignmentStatistics],
        xValueMapper: (AssignmentStatistics data, _) => title,
        yValueMapper: yValueMapper,
        name: 'Gold',
        color: ColorManager.darkPrimary);
  }
}
