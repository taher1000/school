import 'resources/color_manager.dart';
import 'package:flutter/material.dart';

import 'resources/routes_manager.dart';
import 'resources/assets_manager.dart';

abstract class AppConstants {
  static const int gridPageSize = 5;
  static const int listPageSize = 12;
  static const List homeImagesList = [
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

  static const List homeScreensList =
      // [
      //   Routes.teacherProgressRoute,
      //   Routes.teacherAssignmentRoute,
      //   Routes.teacherStudentActivitiesRoute,
      //   Routes.teacherAudioReadingRoute,
      //   Routes.teacherComparePerformanceRoute,
      //   Routes.teacherLearningStylesRoute,
      //   Routes.teacherClassroomRoute,
      //   Routes.teacherMessagesRoute,
      //   Routes.booksRoute,
      //   Routes.teacherTrainingRoute,
      // ];
      [
    Routes.assignmentStatisticsRoute,
    Routes.teacherAssignmentRoute,
    Routes.underConsRoute,
    Routes.underConsRoute,
    Routes.underConsRoute,
    Routes.underConsRoute,
    Routes.underConsRoute,
    Routes.underConsRoute,
    Routes.underConsRoute,
    Routes.underConsRoute,
  ];

  static const List homeTitlesList = [
    "progress",
    "assignments",
    "student_activities",
    "audio_reading",
    "compare_performance",
    "learning_styles",
    "classroom",
    "my_messages",
    "browse_content",
    "training",
  ];

  static const Map<String, int> bookLevelImages = {
    ImageAssets.charA: 1,
    ImageAssets.charB: 2,
    ImageAssets.charC: 3,
    ImageAssets.charD: 4,
    ImageAssets.charE: 5,
    ImageAssets.charF: 6,
    ImageAssets.charG: 7,
    ImageAssets.charH: 8,
    ImageAssets.charI: 9,
    ImageAssets.charJ: 10,
    ImageAssets.charK: 11,
    ImageAssets.charL: 12,
    ImageAssets.charM: 13,
    ImageAssets.charN: 14,
    ImageAssets.charO: 15,
    ImageAssets.charP: 16,
    ImageAssets.charQ: 17,
    ImageAssets.charR: 18,
    ImageAssets.charS: 19,
  };

  static List<Color> colors = <Color>[
    ColorManager.darkPrimary,
    ColorManager.primary,
    ColorManager.secondry,
    ColorManager.secondryLight,
    ColorManager.darkGrey,
    ColorManager.grey,
    ColorManager.green,
    ColorManager.grey1,
    ColorManager.greyDark,
    ColorManager.greyTextColor,
    ColorManager.darkGreyText,
  ];
}
