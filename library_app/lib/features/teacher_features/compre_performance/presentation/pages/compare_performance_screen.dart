import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      screenTitle: localize("مقارنة الاداء"),
      body: Expanded(
          // height: 200,
          // width: 150,
          child: SizedBox()),
    );
  }
}
