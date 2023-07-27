import 'package:ebook/core/navigation/custom_navigation.dart';
import 'package:ebook/core/resources/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/widgets/header_info_widget.dart';
import '../../../../core/widgets/info_container.dart';
import '../../../../core/widgets/main_info_container.dart';

class TeacherBodyComponent extends StatelessWidget {
  const TeacherBodyComponent({super.key});

  @override
  Widget build(BuildContext context) {
    List list = [
      "متابعة التقدم",
      "الواجبات",
      "نشاطات الطلاب",
      "القراءة الصوتية",
      "مقارنة الاداء",
      "انماط التعلم",
      "غرفة الصف",
      "رسائلي",
      "تصفح المحتوي",
      "تدريب"
    ];
    List imagesList = [
      SvgAssets.progress,
      SvgAssets.assignment,
      SvgAssets.studentActivities,
      SvgAssets.audioRead,
      SvgAssets.comparePerformance,
      SvgAssets.learningStyles,
      SvgAssets.classRoom,
      SvgAssets.messages,
      SvgAssets.browseContent,
      SvgAssets.training,
    ];

    List screensList = [
      Routes.teacherProgressRoute,
      Routes.teacherAssignmentRoute,
      Routes.teacherStudentActivitiesRoute,
      Routes.teacherAudioReadingRoute,
      Routes.teacherComparePerformanceRoute,
      Routes.teacherLearningStylesRoute,
      Routes.teacherClassroomRoute,
      Routes.messagesRoute,
      Routes.browseContentRoute,
      Routes.teacherTrainingRoute,
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const HeaderInfoWidget(isTeacher: true),
        Expanded(
          flex: 3,
          child: SizedBox(
            // color: Colors.blue,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 150,
                crossAxisSpacing: 12,
                mainAxisSpacing: AppMargin.m12,
              ),
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return InfoContainerWidget(
                  svgIcon: imagesList[index],
                  title: list[index],
                  onTap: () {
                    CustomNavigator.pushInSubNavigator(screensList[index]);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
