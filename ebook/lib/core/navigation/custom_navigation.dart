import 'package:ebook/injection_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/main/main_screen.dart';
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
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case Routes.mainRoute:
        return MaterialPageRoute(
            builder: (_) => setupDependenciesMainScreen(child: MainScreen()));
      default:
        {
          //   final services = generateServiceRoute(settings);

          //   if (services != null) {
          //     return services;
          //   }
          // final more = generateMoreRoute(settings);

          // if (more != null) {
          //   return more;
          // }
          // final help = generateHelpRoute(settings);

          // if (help != null) {
          //   return help;
          // }

          return MaterialPageRoute(builder: (_) => SplashScreen());
        }
    }
  }

  // static Route generateHomeRoute(RouteSettings settings) {
  //   Map<String, dynamic> data = settings.arguments != null
  //       ? settings.arguments as Map<String, dynamic>
  //       : {};
  //   switch (settings.name) {
  //     case Routes.HOME_SCREEN:
  //       return MaterialPageRoute(builder: (_) => HomeScreen());

  //     default:
  //       {
  //         final services = generateServiceRoute(settings);

  //         if (services != null) {
  //           return services;
  //         }

  //         return MaterialPageRoute(builder: (_) => HomeScreen());
  //       }
  //   }
  // }

  // static Route? generateServiceRoute(RouteSettings settings) {
  //   Map<String, dynamic> data = settings.arguments != null
  //       ? settings.arguments as Map<String, dynamic>
  //       : {};
  //   switch (settings.name) {
  //     case Routes.SERVICES_SCREEN:
  //       return MaterialPageRoute(builder: (_) => ServicesScreen());

  //     default:
  //       {}
  //   }
  // }

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
        builder: (context) => GuestMessage(),
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
