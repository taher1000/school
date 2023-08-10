import 'package:ebook/core/constants.dart';
import 'package:ebook/core/resources/app_localization.dart';
import 'package:ebook/core/resources/color_manager.dart';
import 'package:ebook/core/resources/font_manager.dart';
import 'package:ebook/core/resources/styles_manager.dart';
import 'package:ebook/core/widgets/scaffolds/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../core/entities/student.dart';

class AssignmentFollowUpScreen extends StatefulWidget {
  const AssignmentFollowUpScreen({super.key});

  @override
  State<AssignmentFollowUpScreen> createState() =>
      _AssignmentFollowUpScreenState();
}

class _AssignmentFollowUpScreenState extends State<AssignmentFollowUpScreen> {
  late StudentDataSource _employeeDataSource;

  List<Student> _students = <Student>[];

  @override
  void initState() {
    super.initState();
    _students = AppConstants.dummyStudentsData;
    _employeeDataSource = StudentDataSource(employees: _students);
  }

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;
    return CustomScaffold(
      screenTitle: localize('follow_assignment'),
      body: Expanded(
        // height: 200,
        // width: 150,
        child: SfDataGrid(
          gridLinesVisibility: GridLinesVisibility.both,
          headerGridLinesVisibility: GridLinesVisibility.both,
          source: _employeeDataSource,
          columnWidthMode: ColumnWidthMode.auto,
          columnWidthCalculationRange: ColumnWidthCalculationRange.allRows,
          columns: [
            GridColumn(
                columnName: 'الطالب',
                label: Container(
                  color: ColorManager.secondryLight,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    localize('student'),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleManager.getSemiBoldStyle(
                        color: ColorManager.black, fontSize: FontSize.s14),
                  ),
                )),
            GridColumn(
                columnName: 'numberOfHomeWork',
                label: Container(
                  color: ColorManager.secondryLight,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    localize('total'),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleManager.getSemiBoldStyle(
                        color: ColorManager.black, fontSize: FontSize.s14),
                  ),
                )),
            GridColumn(
                columnName: 'numberOfHomeWorkCompleted',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  color: ColorManager.secondryLight,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    localize('completed'),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleManager.getSemiBoldStyle(
                        color: ColorManager.black, fontSize: FontSize.s14),
                  ),
                )),
            GridColumn(
                columnName: 'numberOfHomeWorkRemaining',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  color: ColorManager.secondryLight,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    localize('remaining'),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleManager.getSemiBoldStyle(
                        color: ColorManager.black, fontSize: FontSize.s14),
                  ),
                )),
            GridColumn(
                columnName: 'numberOfReadingAssignments',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  color: ColorManager.secondryLight,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    localize('total'),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleManager.getSemiBoldStyle(
                        color: ColorManager.black, fontSize: FontSize.s14),
                  ),
                )),
            GridColumn(
                columnName: 'completedReadingAssignments',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  color: ColorManager.secondryLight,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    localize('completed'),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleManager.getSemiBoldStyle(
                        color: ColorManager.black, fontSize: FontSize.s14),
                  ),
                )),
            GridColumn(
                columnName: 'numberOfListeningAssignments',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  color: ColorManager.secondryLight,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    localize('total'),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleManager.getSemiBoldStyle(
                        color: ColorManager.black, fontSize: FontSize.s14),
                  ),
                )),
            GridColumn(
                columnName: 'completedListeningAssignments',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  color: ColorManager.secondryLight,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    localize('completed'),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleManager.getSemiBoldStyle(
                        color: ColorManager.black, fontSize: FontSize.s14),
                  ),
                )),
            GridColumn(
                columnName: 'numberOfTests',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  color: ColorManager.secondryLight,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    localize('total'),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleManager.getSemiBoldStyle(
                        color: ColorManager.black, fontSize: FontSize.s14),
                  ),
                )),
            GridColumn(
                columnName: 'numberOfTestsCompleted',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  color: ColorManager.secondryLight,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    localize('completed'),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleManager.getSemiBoldStyle(
                        color: ColorManager.black, fontSize: FontSize.s14),
                  ),
                )),
            GridColumn(
                columnName: 'numberOfTasks',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  color: ColorManager.secondryLight,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    localize('tasks'),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleManager.getSemiBoldStyle(
                        color: ColorManager.black, fontSize: FontSize.s14),
                  ),
                )),
            GridColumn(
                columnName: 'completedTasks',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  color: ColorManager.secondryLight,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    localize('completed'),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleManager.getSemiBoldStyle(
                        color: ColorManager.black, fontSize: FontSize.s14),
                  ),
                )),
            GridColumn(
                columnName: 'remainingTasks',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  color: ColorManager.secondryLight,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    localize('remaining'),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleManager.getSemiBoldStyle(
                        color: ColorManager.black, fontSize: FontSize.s14),
                  ),
                )),
          ],
          stackedHeaderRows: <StackedHeaderRow>[
            StackedHeaderRow(cells: [
              StackedHeaderCell(
                  columnNames: [
                    'numberOfHomeWork',
                    'numberOfHomeWorkCompleted',
                    'numberOfHomeWorkRemaining'
                  ],
                  child: Container(
                      color: const Color(0xFFF1F1F1),
                      child: Center(
                          child: Text(
                        'الواجبات',
                        style: TextStyleManager.getBoldStyle(
                            color: ColorManager.black, fontSize: FontSize.s16),
                      )))),
              StackedHeaderCell(
                  columnNames: [
                    'numberOfReadingAssignments',
                    'completedReadingAssignments'
                  ],
                  child: Container(
                      color: const Color(0xFFF1F1F1),
                      child: Center(
                          child: Text(
                        'القراءة',
                        style: TextStyleManager.getBoldStyle(
                            color: ColorManager.black, fontSize: FontSize.s16),
                      )))),
              StackedHeaderCell(
                  columnNames: [
                    'numberOfListeningAssignments',
                    'completedListeningAssignments'
                  ],
                  child: Container(
                      color: const Color(0xFFF1F1F1),
                      child: Center(
                          child: Text(
                        'الاستماع',
                        style: TextStyleManager.getBoldStyle(
                            color: ColorManager.black, fontSize: FontSize.s16),
                      )))),
              StackedHeaderCell(
                  columnNames: ['numberOfTests', 'numberOfTestsCompleted'],
                  child: Container(
                      color: const Color(0xFFF1F1F1),
                      child: Center(
                          child: Text(
                        'الاختبارات',
                        style: TextStyleManager.getBoldStyle(
                            color: ColorManager.black, fontSize: FontSize.s16),
                      )))),
              StackedHeaderCell(
                  columnNames: [
                    'numberOfTasks',
                    'completedTasks',
                    'remainingTasks'
                  ],
                  child: Container(
                      color: const Color(0xFFF1F1F1),
                      child: Center(
                          child: Text(
                        'المهام',
                        style: TextStyleManager.getBoldStyle(
                            color: ColorManager.black, fontSize: FontSize.s16),
                      ))))
            ])
          ],
        ),
      ),
    );
  }
}

class StudentDataSource extends DataGridSource {
  StudentDataSource({required List<Student> employees}) {
    dataGridRows = employees
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'الطالب', value: dataGridRow.name),
              DataGridCell<int>(
                  columnName: 'numberOfHomeWork',
                  value: dataGridRow.allAssignments),
              DataGridCell<int>(
                  columnName: 'numberOfHomeWorkCompleted',
                  value: dataGridRow.completedAssignments),
              DataGridCell<int>(
                  columnName: 'numberOfHomeWorkRemaining',
                  value: dataGridRow.remainingAssignments),
              DataGridCell<int>(
                  columnName: 'numberOfReadingAssignments',
                  value: dataGridRow.readingAssignments),
              DataGridCell<int>(
                  columnName: 'completedReadingAssignments',
                  value: dataGridRow.completedReadingAssignments),
              DataGridCell<int>(
                  columnName: 'numberOfListeningAssignments',
                  value: dataGridRow.listeningAssignments),
              DataGridCell<int>(
                  columnName: 'completedListeningAssignments',
                  value: dataGridRow.completedListeningAssignments),
              DataGridCell<int>(
                  columnName: 'numberOfTests', value: dataGridRow.tests),
              DataGridCell<int>(
                  columnName: 'numberOfTestsCompleted',
                  value: dataGridRow.completedTests),
              DataGridCell<int>(
                  columnName: 'numberOfTasks',
                  value: dataGridRow.numberOfTasks),
              DataGridCell<int>(
                  columnName: 'completedTasks',
                  value: dataGridRow.completedTasks),
              DataGridCell<int>(
                  columnName: 'remainingTasks',
                  value: dataGridRow.remainingTasks),
            ]))
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ));
    }).toList());
  }
}
