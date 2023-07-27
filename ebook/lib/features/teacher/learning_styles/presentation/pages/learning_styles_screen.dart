import 'package:ebook/core/resources/app_localization.dart';
import 'package:ebook/core/resources/color_manager.dart';
import 'package:ebook/core/resources/font_manager.dart';
import 'package:ebook/core/resources/styles_manager.dart';
import 'package:ebook/core/widgets/scaffolds/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../core/entities/student.dart';

class LearningStylesScreen extends StatefulWidget {
  const LearningStylesScreen({super.key});

  @override
  State<LearningStylesScreen> createState() => _LearningStylesScreenState();
}

class _LearningStylesScreenState extends State<LearningStylesScreen> {
  late StudentDataSource _employeeDataSource;

  List<Student> _students = <Student>[];

  @override
  void initState() {
    super.initState();
    _students = getStudentsData();
    _employeeDataSource = StudentDataSource(employees: _students);
  }

  List<Student> getStudentsData() {
    return [
      Student(
        name: 'Ali Ahmed',
        allAssignments: 10,
        completedAssignments: 5,
        remainingAssignments: 5,
        readingAssignments: 5,
        completedReadingAssignments: 5,
        listeningAssignments: 5,
        completedListeningAssignments: 5,
        tests: 5,
        completedTests: 5,
        numberOfTasks: 4,
        completedTasks: 8,
        remainingTasks: 9,
      ),
      Student(
        name: 'Mohamed Ibrahim',
        allAssignments: 10,
        completedAssignments: 5,
        remainingAssignments: 5,
        readingAssignments: 5,
        completedReadingAssignments: 5,
        listeningAssignments: 5,
        completedListeningAssignments: 5,
        tests: 5,
        completedTests: 5,
        numberOfTasks: 4,
        completedTasks: 8,
        remainingTasks: 9,
      ),
      Student(
        name: 'Ahmed Ali',
        allAssignments: 10,
        completedAssignments: 5,
        remainingAssignments: 5,
        readingAssignments: 5,
        completedReadingAssignments: 5,
        listeningAssignments: 5,
        completedListeningAssignments: 5,
        tests: 5,
        completedTests: 5,
        numberOfTasks: 4,
        completedTasks: 8,
        remainingTasks: 9,
      ),
      Student(
        name: 'Ibrahim Mohamed',
        allAssignments: 10,
        completedAssignments: 5,
        remainingAssignments: 5,
        readingAssignments: 5,
        completedReadingAssignments: 5,
        listeningAssignments: 5,
        completedListeningAssignments: 5,
        tests: 5,
        completedTests: 5,
        numberOfTasks: 4,
        completedTasks: 8,
        remainingTasks: 9,
      ),
      Student(
        name: 'Ali Ahmed',
        allAssignments: 10,
        completedAssignments: 5,
        remainingAssignments: 5,
        readingAssignments: 5,
        completedReadingAssignments: 5,
        listeningAssignments: 5,
        completedListeningAssignments: 5,
        tests: 5,
        completedTests: 5,
        numberOfTasks: 4,
        completedTasks: 8,
        remainingTasks: 9,
      ),
      Student(
        name: 'Mohamed Ibrahim',
        allAssignments: 10,
        completedAssignments: 5,
        remainingAssignments: 5,
        readingAssignments: 5,
        completedReadingAssignments: 5,
        listeningAssignments: 5,
        completedListeningAssignments: 5,
        tests: 5,
        completedTests: 5,
        numberOfTasks: 4,
        completedTasks: 8,
        remainingTasks: 9,
      ),
      Student(
        name: 'Ahmed Ali',
        allAssignments: 10,
        completedAssignments: 5,
        remainingAssignments: 5,
        readingAssignments: 5,
        completedReadingAssignments: 5,
        listeningAssignments: 5,
        completedListeningAssignments: 5,
        tests: 5,
        completedTests: 5,
        numberOfTasks: 4,
        completedTasks: 8,
        remainingTasks: 9,
      ),
      Student(
        name: 'Ibrahim Mohamed',
        allAssignments: 10,
        completedAssignments: 5,
        remainingAssignments: 5,
        readingAssignments: 5,
        completedReadingAssignments: 5,
        listeningAssignments: 5,
        completedListeningAssignments: 5,
        tests: 5,
        completedTests: 5,
        numberOfTasks: 4,
        completedTasks: 8,
        remainingTasks: 9,
      ),
      Student(
        name: 'Ali Ahmed',
        allAssignments: 10,
        completedAssignments: 5,
        remainingAssignments: 5,
        readingAssignments: 5,
        completedReadingAssignments: 5,
        listeningAssignments: 5,
        completedListeningAssignments: 5,
        tests: 5,
        completedTests: 5,
        numberOfTasks: 4,
        completedTasks: 8,
        remainingTasks: 9,
      ),
      Student(
        name: 'Mohamed Ibrahim',
        allAssignments: 10,
        completedAssignments: 5,
        remainingAssignments: 5,
        readingAssignments: 5,
        completedReadingAssignments: 5,
        listeningAssignments: 5,
        completedListeningAssignments: 5,
        tests: 5,
        completedTests: 5,
        numberOfTasks: 4,
        completedTasks: 8,
        remainingTasks: 9,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;
    return CustomScaffold(
      screenTitle: localize("انماط التعلم"),
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
                  alignment: Alignment.center,
                  child: Text(
                    'الطالب',
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
                  alignment: Alignment.center,
                  child: Text(
                    'الكتب المقروءة',
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
                  alignment: Alignment.center,
                  child: Text(
                    'الكتب المسموعة',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleManager.getSemiBoldStyle(
                        color: ColorManager.black, fontSize: FontSize.s14),
                  ),
                )),
            GridColumn(
                columnName: 'numberOfTasksAssignments',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  color: ColorManager.secondryLight,
                  alignment: Alignment.center,
                  child: Text(
                    'الاختبارات المنفذه',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleManager.getSemiBoldStyle(
                        color: ColorManager.black, fontSize: FontSize.s14),
                  ),
                )),
            GridColumn(
                columnName: 'numberOfTasksAssignmentsCompleted',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  color: ColorManager.secondryLight,
                  alignment: Alignment.center,
                  child: FaIcon(
                    FontAwesomeIcons.bookOpen,
                    color: ColorManager.darkPrimary,
                  ),
                )),
            GridColumn(
                columnName: 'records',
                label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    color: ColorManager.secondryLight,
                    alignment: Alignment.center,
                    child: FaIcon(
                      FontAwesomeIcons.headphones,
                      color: ColorManager.darkPrimary,
                    ))),
            GridColumn(
                columnName: 'sumOfActivities',
                label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    color: ColorManager.secondryLight,
                    alignment: Alignment.center,
                    child: FaIcon(
                      FontAwesomeIcons.solidCircleQuestion,
                      color: ColorManager.darkPrimary,
                    ))),
            GridColumn(
                columnName: 'details',
                label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    color: ColorManager.secondryLight,
                    alignment: Alignment.center,
                    child: FaIcon(
                      FontAwesomeIcons.chartColumn,
                      color: ColorManager.darkPrimary,
                    ))),
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
                  columnName: 'numberOfTasksAssignments',
                  value: dataGridRow.readingAssignments),
              DataGridCell<int>(
                  columnName: 'numberOfTasksAssignmentsCompleted',
                  value: dataGridRow.completedReadingAssignments),
              DataGridCell<int>(
                  columnName: 'records',
                  value: dataGridRow.listeningAssignments),
              DataGridCell<int>(
                  columnName: 'sumOfActivities',
                  value: dataGridRow.completedListeningAssignments),
              DataGridCell<int>(
                  columnName: 'details',
                  value: dataGridRow.completedReadingAssignments),
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
          child: dataGridCell.columnName == 'details'
              ? FaIcon(
                  FontAwesomeIcons.chartSimple,
                  color: ColorManager.darkPrimary,
                )
              : Text(
                  dataGridCell.value.toString(),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ));
    }).toList());
  }
}
