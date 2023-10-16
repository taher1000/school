import '../../../../../core/resources/app_localization.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      body: Expanded(
          // height: 200,
          // width: 150,
          child: SizedBox()),
    );
  }
}
