import 'package:ebook/core/resources/app_localization.dart';

import '../../../../../core/resources/routes_manager.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/widgets/buttons/menu_button.dart';

class TeacherAssignmentScreen extends StatefulWidget {
  const TeacherAssignmentScreen({super.key});

  @override
  State<TeacherAssignmentScreen> createState() =>
      _TeacherAssignmentScreenState();
}

class _TeacherAssignmentScreenState extends State<TeacherAssignmentScreen> {
  @override
  Widget build(BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;
    return CustomScaffold(
      screenTitle: localize("assignments"),
      body: Column(
        children: [
          MenuButton(
            iconPath: FontAwesomeIcons.bookMedical,
            title: localize("create_reading_assignment"),
            route: Routes.addAssignmentRoute,
          ),
          SizedBox(
            height: 16.h,
          ),
          MenuButton(
            iconPath: FontAwesomeIcons.calendarCheck,
            title: localize("follow_assignment"),
            route: Routes.assignmentFollowUpRoute,
          ),
          SizedBox(
            height: 16.h,
          ),
          MenuButton(
            iconPath: FontAwesomeIcons.solidRectangleList,
            title: localize("assignments_list"),
            route: Routes.assignmentListRoute,
          ),
        ],
      ),
    );
  }
}
