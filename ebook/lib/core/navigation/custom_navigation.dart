import 'package:ebook/features/books/presentation/bloc/books_bloc.dart';
import 'package:ebook/features/books/presentation/pages/books_screen.dart';
import 'package:ebook/features/chat/presentation/pages/chats_screen.dart';
import 'package:ebook/features/main/presentation/screens/main_screen.dart';
import 'package:ebook/features/on_boarding/on_boarding_screen.dart';
import 'package:ebook/features/profile/presentation/pages/profile_screen.dart';
import 'package:ebook/features/quiz/presentation/pages/quiz_screen.dart';
import 'package:ebook/features/sign_in/presentation/pages/sign_in_screen.dart';
import 'package:ebook/features/teacher/assignment/presentation/bloc/assignment_bloc.dart';
import 'package:ebook/features/teacher/assignment/presentation/pages/assignment_followup.dart';
import 'package:ebook/features/teacher/assignment/presentation/pages/assignmets_list_screen.dart';
import 'package:ebook/features/teacher/browse_content/presentation/pages/browse_content_screen.dart';
import 'package:ebook/features/teacher/classroom/presentation/pages/classroom_screen.dart';
import 'package:ebook/features/teacher/classroom/presentation/pages/reading_level_adjustment.dart';
import 'package:ebook/features/teacher/compre_performance/presentation/pages/compare_performance_screen.dart';
import 'package:ebook/features/teacher/learning_styles/presentation/pages/learning_styles_screen.dart';
import 'package:ebook/features/teacher/messages/presentation/pages/messages_screen.dart';
import 'package:ebook/features/teacher/progress/presentation/pages/progress_screen.dart';
import 'package:ebook/features/teacher/training/presentation/pages/training_screen.dart';

import '../../features/home/presentation/pages/home_teacher_screen.dart';
import '../../features/main/presentation/screens/get_all_data_screen.dart';
import '../../features/sign_in/presentation/bloc/sign_in_bloc.dart';
import '../../features/teacher/assignment/presentation/pages/add_assignment_screen.dart';
import '../../features/teacher/assignment/presentation/pages/assignment_screen.dart';
import '../../features/teacher/audio_reading/presentation/pages/audio_reading_screen.dart';
import '../../features/teacher/classroom/presentation/pages/add_student_group_screen.dart';
import '../../features/teacher/classroom/presentation/pages/edit_student_info_screen.dart';
import '../../features/teacher/classroom/presentation/pages/my_papers_screen.dart';
import '../../features/teacher/student_activities/presentation/pages/student_activities_screen.dart';
import '../../injection_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/main/splash_screen.dart';
import '../resources/routes_manager.dart';
import '../widgets/popup/guest_message.dart';

/// Global Context of App
BuildContext? get currentContext =>
    CustomNavigator.navigatorState.currentContext;

/// Global Context of App
BuildContext? get currentContextWithBottomNav =>
    CustomNavigator.navigatorKeysBottomNav[selectedTab].currentContext;

abstract class CustomNavigator {
  static final GlobalKey<NavigatorState> navigatorState = GlobalKey();

  static List<GlobalKey<NavigatorState>> navigatorKeysBottomNav = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];
  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();

  static Route<dynamic> onCreateRoute(RouteSettings settings) {
    Map<String, dynamic> data = settings.arguments != null
        ? settings.arguments as Map<String, dynamic>
        : {};
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case Routes.mainRoute:
        return MaterialPageRoute(
            builder: (_) =>
                setupDependenciesMainScreen(child: const MainScreen()));
      case Routes.loginRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<SignInBloc>(
                create: (_) => SignInBloc(getIt()),
                child: const SignInScreen()));
      case Routes.getAllUserDataRoute:
        return MaterialPageRoute(
          builder: (context) => const GetAllDataScreen(),
        );

      default:
        {
          final screens = generateHomeRoute(settings);

          if (screens != null) {
            return screens;
          }
          // !should be splash screen

          return MaterialPageRoute(builder: (_) => const SplashScreen());
        }
    }
  }

  static Route generateHomeRoute(RouteSettings settings) {
    Map<String, dynamic> data = settings.arguments != null
        ? settings.arguments as Map<String, dynamic>
        : {};
    switch (settings.name) {
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case Routes.booksRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<BooksBloc>(
                  create: (context) => BooksBloc(getIt()),
                  child: const BooksScreen(),
                ));

      case Routes.quizRoute:
        return MaterialPageRoute(builder: (_) => QuizScreen());
      case Routes.chatRoute:
        return MaterialPageRoute(builder: (_) => const ChatsScreen());
      case Routes.profileRoute:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      default:
        {
          final services = generateServicesRoute(settings);

          if (services != null) {
            return services;
          }

          return MaterialPageRoute(builder: (_) => const HomeScreen());
        }
    }
  }

  static Route? generateServicesRoute(RouteSettings settings) {
    Map<String, dynamic> data = settings.arguments != null
        ? settings.arguments as Map<String, dynamic>
        : {};
    switch (settings.name) {
      // case Routes.bookDetailsRoute:
      //   return MaterialPageRoute(
      //       builder: (_) => BookDetailsScreen(
      //             book: data["book"],
      //           ));

      case Routes.teacherProgressRoute:
        return MaterialPageRoute(builder: (_) => const TeacherProgressScreen());
      case Routes.teacherAssignmentRoute:
        return MaterialPageRoute(
            builder: (_) => const TeacherAssignmentScreen());
      case Routes.addAssignmentRoute:
        return MaterialPageRoute(builder: (_) => const AddAssignmentScreen());
      case Routes.assignmentFollowUpRoute:
        return MaterialPageRoute(
            builder: (_) => const AssignmentFollowUpScreen());
      case Routes.assignmentListRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<AssignmentBloc>(
                  create: (context) => AssignmentBloc(getIt()),
                  child: const AssignmentsListScreen(),
                ));
      case Routes.teacherStudentActivitiesRoute:
        return MaterialPageRoute(
            builder: (_) => const StudentActivitiesScreen());
      case Routes.teacherAudioReadingRoute:
        return MaterialPageRoute(builder: (_) => const AudioReadingScreen());
      case Routes.teacherComparePerformanceRoute:
        return MaterialPageRoute(
            builder: (_) => const ComparePerformanceScreen());
      case Routes.teacherLearningStylesRoute:
        return MaterialPageRoute(builder: (_) => const LearningStylesScreen());
      case Routes.browseContentRoute:
        return MaterialPageRoute(builder: (_) => const BrowseContentScreen());
      case Routes.teacherClassroomRoute:
        return MaterialPageRoute(
            builder: (_) => const TeacherClassRoomScreen());
      case Routes.teacherMessagesRoute:
        return MaterialPageRoute(builder: (_) => const TeacherMessagesScreen());
      case Routes.teacherTrainingRoute:
        return MaterialPageRoute(builder: (_) => const TeacherTrainingScreen());
      case Routes.teacherPapersRoute:
        return MaterialPageRoute(builder: (_) => const MyPapersScreen());
      case Routes.readingLevelAdjustmentRoute:
        return MaterialPageRoute(
            builder: (_) => const ReadingLevelAdjustment());
      case Routes.addStudentGroupRoute:
        return MaterialPageRoute(builder: (_) => const AddStudentGroupScreen());
      case Routes.teacherEditStudentInfoScreenRoute:
        return MaterialPageRoute(
            builder: (_) => const TeacherEditStudentInfoScreen());
      default:
        {
          return MaterialPageRoute(builder: (_) => const HomeScreen());
        }
    }
  }

  // static Route? generateHelpRoute(RouteSettings settings) {
  //   switch (settings.name) {
  //     case Routes.HELP_SCREEN:
  //       return MaterialPageRoute(builder: (_) => HelpScreen());
  //   }
  //   return null;
  // }

  // static Route? generateMoreRoute(RouteSettings settings) {
  //   Map<String, dynamic> data = settings.arguments != null
  //       ? settings.arguments as Map<String, dynamic>
  //       : {};
  //   switch (settings.name) {
  //     case Routes.MORE_SCREEN:
  //       return MaterialPageRoute(builder: (context) => MoreScreen());
  //   }
  //   return null;
  // }

  // static Route generateSettingRoute(RouteSettings settings) {
  //   switch (settings.name) {
  //     case Routes.SETTINGS_SCREEN:
  //       return MaterialPageRoute(
  //           builder: (_) => SettingsScreen(
  //                 usecase: getIt(),
  //               ));
  //     case Routes.PROFILE_SCREEN:
  //       return MaterialPageRoute(
  //         builder: (context) => ProfileScreen(),
  //       );

  //     default:
  //       {
  //         return MaterialPageRoute(
  //             builder: (_) => SettingsScreen(
  //                   usecase: getIt(),
  //                 ));
  //       }
  //   }
  // }

  static void pop({dynamic result}) {
    if (navigatorState.currentState!.canPop()) {
      navigatorState.currentState!.pop(result);
    }
  }

  // track navigation of user
  static push(
    String routeName, {
    arguments,
    bool replace = false,
    bool clean = false,
    bool Function(Route<dynamic>)? predicate,
  }) {
    if (navigatorState.currentState != null) {
      if (clean) {
        return navigatorState.currentState!.pushNamedAndRemoveUntil(
          routeName,
          predicate ?? (_) => false,
          arguments: arguments,
        );
      } else if (replace) {
        return navigatorState.currentState!
            .pushReplacementNamed(routeName, arguments: arguments);
      } else {
        return navigatorState.currentState!
            .pushNamed(routeName, arguments: arguments);
      }
    }
  }

  static void popInSubNavigator(
      {dynamic result, bool Function(Route<dynamic>)? predicate}) {
    if (navigatorKeysBottomNav[selectedTab].currentState!.canPop()) {
      predicate != null
          ? navigatorKeysBottomNav[selectedTab]
              .currentState!
              .popUntil(predicate)
          : navigatorKeysBottomNav[selectedTab].currentState!.pop(result);
    }
  }

  // static clickActionNotification() {
  //   if (MessagingConfig.clickAction.isNotEmpty) {
  //     CustomNavigator.pushInSubNavigator(MessagingConfig.clickAction);
  //     MessagingConfig.clickAction = '';
  //   }
  // }

  static pushInSubNavigator(String routeName,
      {arguments,
      bool replace = false,
      bool clean = false,
      bool rootNavigator = false,
      bool digitalIdentityRequired = false,
      bool Function(Route<dynamic>)? predicate,
      bool authRequired = false}) {
    BuildContext context =
        navigatorKeysBottomNav[selectedTab].currentState!.context;

    if (authRequired && sharedPrefsClient.accessToken == "") {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => const GuestMessage(),
        useRootNavigator: true,
      );
    } else {
      if (clean) {
        return Navigator.of(context, rootNavigator: rootNavigator)
            .pushNamedAndRemoveUntil(
          routeName,
          predicate ?? (_) => false,
          arguments: arguments,
        );
      } else if (replace) {
        return Navigator.of(context, rootNavigator: rootNavigator)
            .pushReplacementNamed(routeName, arguments: arguments);
      } else {
        return Navigator.of(context, rootNavigator: rootNavigator)
            .pushNamed(routeName, arguments: arguments);
      }
    }
  }
}
