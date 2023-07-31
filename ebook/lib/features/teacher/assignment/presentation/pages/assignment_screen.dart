import 'package:ebook/core/navigation/navigator.dart';
import 'package:ebook/core/resources/color_manager.dart';
import 'package:ebook/core/resources/font_manager.dart';
import 'package:ebook/core/resources/routes_manager.dart';
import 'package:ebook/core/resources/styles_manager.dart';
import 'package:ebook/core/resources/values_manager.dart';
import 'package:ebook/core/widgets/scaffolds/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/resources/app_localization.dart';
import '../../../../../core/widgets/buttons/menu_button.dart';
import '../../../../../core/widgets/textfield/custom_dropdown.dart';
import '../../../../../core/widgets/text/custom_text.dart';

class TeacherAssignmentScreen extends StatefulWidget {
  const TeacherAssignmentScreen({super.key});

  @override
  State<TeacherAssignmentScreen> createState() =>
      _TeacherAssignmentScreenState();
}

class _TeacherAssignmentScreenState extends State<TeacherAssignmentScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      screenTitle: "Students Assignment",
      body: Column(
        children: [
          const MenuButton(
            iconPath: FontAwesomeIcons.bookMedical,
            title: "انشاء واجب قرائي",
            route: Routes.addAssignmentRoute,
          ),
          SizedBox(
            height: 16.h,
          ),
          const MenuButton(
            iconPath: FontAwesomeIcons.calendarCheck,
            title: "متابعة الواجبات",
            route: Routes.assignmentFollowUpRoute,
          ),
          SizedBox(
            height: 16.h,
          ),
          const MenuButton(
            iconPath: FontAwesomeIcons.solidRectangleList,
            title: "قائمة الواجبات",
            route: Routes.assignmentListRoute,
          ),
        ],
      ),
    );
  }
}
