import '../../../../../core/resources/app_localization.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';
import 'package:flutter/material.dart';

import '../../../../students/domain/entities/student.dart';

class StudentActivitiesScreen extends StatefulWidget {
  const StudentActivitiesScreen({super.key});

  @override
  State<StudentActivitiesScreen> createState() =>
      _StudentActivitiesScreenState();
}

class _StudentActivitiesScreenState extends State<StudentActivitiesScreen> {
  List<Student> _students = <Student>[];

  @override
  void initState() {
    super.initState();
    _students = getStudentsData();
  }

  List<Student> getStudentsData() {
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;
    return CustomScaffold(
      screenTitle: localize("نشاطات الطلبة"),
      body: const Expanded(
          // height: 200,
          // width: 150,
          child: SizedBox()),
    );
  }
}
