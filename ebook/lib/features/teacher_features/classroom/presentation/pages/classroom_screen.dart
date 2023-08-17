import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/resources/routes_manager.dart';
import '../../../../../core/widgets/buttons/menu_button.dart';
import '../../../../../core/widgets/scaffolds/custom_scaffold.dart';

class TeacherClassRoomScreen extends StatelessWidget {
  const TeacherClassRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      screenTitle: "غرفة الصف",
      body: Column(
        children: [
          const MenuButton(
            iconPath: FontAwesomeIcons.solidFolderOpen,
            title: "أوراقي",
            route: Routes.teacherPapersRoute,
          ),
          SizedBox(
            height: 16.h,
          ),
          const MenuButton(
            iconPath: FontAwesomeIcons.calendarCheck,
            title: "تعديل المستوي القرائي للطلبة",
            route: Routes.readingLevelAdjustmentRoute,
          ),
          SizedBox(
            height: 16.h,
          ),
          const MenuButton(
            iconPath: FontAwesomeIcons.solidRectangleList,
            title: "أنشاء مجموعات من الطلبة",
            route: Routes.addStudentGroupRoute,
          ),
          SizedBox(
            height: 16.h,
          ),
          const MenuButton(
            iconPath: FontAwesomeIcons.solidRectangleList,
            title: "تعديل بيانات الطالب",
            route: Routes.teacherEditStudentInfoScreenRoute,
          ),
        ],
      ),
    );
  }
}
