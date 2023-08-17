import 'resources/routes_manager.dart';
import 'resources/assets_manager.dart';

abstract class AppConstants {
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

  static const List homeScreensList = [
    Routes.teacherProgressRoute,
    Routes.teacherAssignmentRoute,
    Routes.teacherStudentActivitiesRoute,
    Routes.teacherAudioReadingRoute,
    Routes.teacherComparePerformanceRoute,
    Routes.teacherLearningStylesRoute,
    Routes.teacherClassroomRoute,
    Routes.teacherMessagesRoute,
    Routes.booksRoute,
    Routes.teacherTrainingRoute,
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

  static const List<String> bookLevelImages = [
    ImageAssets.charA,
    ImageAssets.charB,
    ImageAssets.charC,
    ImageAssets.charD,
    ImageAssets.charE,
    ImageAssets.charF,
    ImageAssets.charG,
    ImageAssets.charI,
    ImageAssets.charJ,
    ImageAssets.charK,
    ImageAssets.charL,
    ImageAssets.charM,
    ImageAssets.charN,
    ImageAssets.charO,
    ImageAssets.charP,
    ImageAssets.charQ,
    ImageAssets.charR,
    ImageAssets.charS,
  ];

  static const List<String> classRooms = <String>[
    'الصف الاول',
    'الصف الثاني',
    'الصف الثالث',
    'الصف الرابع',
    'كل الصفوف'
  ];
}
