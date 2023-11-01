import '../../../../../core/resources/app_localization.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';
import 'package:flutter/material.dart';

import '../../../../students/domain/entities/student.dart';

class LearningStylesScreen extends StatefulWidget {
  const LearningStylesScreen({super.key});

  @override
  State<LearningStylesScreen> createState() => _LearningStylesScreenState();
}

class _LearningStylesScreenState extends State<LearningStylesScreen> {
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
      screenTitle: localize("انماط التعلم"),
      body: const Expanded(
          // height: 200,
          // width: 150,
          child: SizedBox()),
    );
  }
}
