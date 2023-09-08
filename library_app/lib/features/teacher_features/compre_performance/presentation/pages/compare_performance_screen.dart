import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../core/resources/app_localization.dart';
import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';
import '../../../../students/domain/entities/student.dart';

class ComparePerformanceScreen extends StatefulWidget {
  const ComparePerformanceScreen({super.key});

  @override
  State<ComparePerformanceScreen> createState() =>
      _ComparePerformanceScreenState();
}

class _ComparePerformanceScreenState extends State<ComparePerformanceScreen> {
  late StudentDataSource _employeeDataSource;

  List<Student> _students = <Student>[];

  @override
  void initState() {
    super.initState();
    _students = getStudentsData();
    _employeeDataSource = StudentDataSource(employees: _students);
  }

  List<Student> getStudentsData() {
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;
    return CustomScaffold(
      screenTitle: localize("مقارنة الاداء"),
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
                columnName: 'details',
                width: 90.w,
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  color: ColorManager.secondryLight,
                  alignment: Alignment.center,
                  child: Text(
                    'المستوي',
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
                    'المعدل العام للاختبار',
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
                    'عدد الاختبارات المنفذه',
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
                    'مؤشر الصف',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleManager.getSemiBoldStyle(
                        color: ColorManager.black, fontSize: FontSize.s14),
                  ),
                )),
            GridColumn(
                columnName: 'sumOfActivities',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  color: ColorManager.secondryLight,
                  alignment: Alignment.center,
                  child: Text(
                    'مقارنة الاداء',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleManager.getSemiBoldStyle(
                        color: ColorManager.black, fontSize: FontSize.s14),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class StudentDataSource extends DataGridSource {
  StudentDataSource({required List<Student> employees}) {
    // dataGridRows = employees
    //     .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
    //           DataGridCell<String>(
    //               columnName: 'الطالب', value: dataGridRow.name),
    //           DataGridCell<int>(
    //               columnName: 'details',
    //               value: dataGridRow.completedReadingAssignments),
    //           DataGridCell<int>(
    //               columnName: 'numberOfHomeWork',
    //               value: dataGridRow.allAssignments),
    //           DataGridCell<int>(
    //               columnName: 'numberOfHomeWorkCompleted',
    //               value: dataGridRow.completedAssignments),
    //           DataGridCell<int>(
    //               columnName: 'numberOfTasksAssignments',
    //               value: dataGridRow.readingAssignments),
    //           DataGridCell<int>(
    //               columnName: 'sumOfActivities',
    //               value: dataGridRow.completedListeningAssignments),
    //         ]))
    //     .toList();
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
          child: dataGridCell.columnName == 'numberOfTasksAssignments'
              ? FaIcon(
                  FontAwesomeIcons.upLong,
                  color: ColorManager.darkPrimary,
                  size: 30,
                )
              : dataGridCell.columnName == 'sumOfActivities'
                  ? FaIcon(
                      FontAwesomeIcons.rankingStar,
                      color: ColorManager.darkPrimary,
                      size: 30,
                    )
                  : dataGridCell.columnName == 'details'
                      ? Image.asset(
                          ImageAssets.charA,
                          // color: ColorManager.darkPrimary,
                        )
                      : Text(
                          dataGridCell.value.toString(),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ));
    }).toList());
  }
}
