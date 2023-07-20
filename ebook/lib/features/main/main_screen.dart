// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:permission_handler/permission_handler.dart';

// import '../../core/navigation/custom_navigation.dart';
// import '../../core/resources/app_localization.dart';
// import '../../core/resources/routes_manager.dart';
// import '../../injection_container.dart';

// class MainScreen extends StatefulWidget {
//   MainScreen({Key? key}) : super(key: key);

//   @override
//   _MainScreenState createState() => _MainScreenState();
// }

// int selectedTab = 0;
// bool showBottomNavBar = true;

// class _MainScreenState extends State<MainScreen> {
// final GlobalKey _bottomNavigationKey = GlobalKey();

// late List<Widget> appPageTab;
// Permission notification = Permission.notification;

// @override
// void initState() {
//   super.initState();

//   CustomNavigator.navigatorKeysBottomNav = [
//     GlobalKey<NavigatorState>(),
//     GlobalKey<NavigatorState>(),
//     GlobalKey<NavigatorState>(),
//     GlobalKey<NavigatorState>(),
//     GlobalKey<NavigatorState>(),
//   ];
//   selectedTab = sharedPrefsClient.accessToken != "" ? 0 : 2;

//   appPageTab = sharedPrefsClient.accessToken != ""
//       ? [
//           Navigator(
//               key: CustomNavigator.navigatorKeysBottomNav[0],
//               initialRoute: Routes.booksRoute,
//               onGenerateRoute: CustomNavigator.generateHomeRoute
//               //generateHomeRoute,
//               ),
//           Navigator(
//               key: CustomNavigator.navigatorKeysBottomNav[1],
//               initialRoute: Routes.quizRoute,
//               onGenerateRoute: CustomNavigator.generateHomeRoute
//               //generateHomeRoute,
//               ),
//           Navigator(
//               key: CustomNavigator.navigatorKeysBottomNav[2],
//               initialRoute: Routes.homeRoute,
//               onGenerateRoute: CustomNavigator.generateHomeRoute
//               //generateHomeRoute,
//               ),
//           Navigator(
//               key: CustomNavigator.navigatorKeysBottomNav[3],
//               initialRoute: Routes.chatRoute,
//               onGenerateRoute: CustomNavigator.generateHomeRoute
//               //generateHomeRoute,
//               ),
//           Navigator(
//               key: CustomNavigator.navigatorKeysBottomNav[4],
//               initialRoute: Routes.profileRoute,
//               onGenerateRoute: CustomNavigator.generateHomeRoute
//               //generateHomeRoute,
//               ),
//         ]
//       : [
//           Navigator(
//               key: CustomNavigator.navigatorKeysBottomNav[0],
//               initialRoute: Routes.booksRoute,
//               onGenerateRoute: CustomNavigator.generateHomeRoute
//               //generateHomeRoute,
//               ),
//           Navigator(
//               key: CustomNavigator.navigatorKeysBottomNav[1],
//               initialRoute: Routes.quizRoute,
//               onGenerateRoute: CustomNavigator.generateHomeRoute
//               //generateHomeRoute,
//               ),
//           Navigator(
//               key: CustomNavigator.navigatorKeysBottomNav[2],
//               initialRoute: Routes.homeRoute,
//               onGenerateRoute: CustomNavigator.generateHomeRoute
//               //generateHomeRoute,
//               ),
//           Navigator(
//               key: CustomNavigator.navigatorKeysBottomNav[3],
//               initialRoute: Routes.chatRoute,
//               onGenerateRoute: CustomNavigator.generateHomeRoute
//               //generateHomeRoute,
//               ),
//           Navigator(
//               key: CustomNavigator.navigatorKeysBottomNav[4],
//               initialRoute: Routes.profileRoute,
//               onGenerateRoute: CustomNavigator.onCreateRoute
//               //generateHomeRoute,
//               ),
//         ];
// }

//   @override
//   Widget build(BuildContext context) {
//     Widget svgIcon(String text) {
//       return Padding(
//         padding: EdgeInsets.only(bottom: 7.0.h),
//         child: SvgPicture.asset(
//           "assets/svg/$text.svg",
//           width: 24,
//           height: 22,
//         ),
//       );
//     }

//     return WillPopScope(
//       onWillPop: () async {
//         final canPop = CustomNavigator
//             .navigatorKeysBottomNav[selectedTab].currentState!
//             .canPop();

//         if (canPop) {
//           CustomNavigator.popInSubNavigator();
//         } else if ((sharedPrefsClient.accessToken != "") && selectedTab != 0) {
//           selectedTab = 0;
//         } else if (sharedPrefsClient.accessToken == "" && selectedTab != 2) {
//           selectedTab = 2;
//         } else {
//           return true;
//         }

//         return false;
//       },
//       child: Scaffold(
//         body:
// sharedPrefsClient.accessToken != ""
//     ?
//             IndexedStack(index: selectedTab, children: appPageTab)
// : Navigator(
//     key: CustomNavigator.navigatorKeysBottomNav[2],
//     initialRoute: Routes.loginRoute,
//     onGenerateRoute: CustomNavigator.onCreateRoute,
//   ),
//         bottomNavigationBar: ClipRRect(
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(25.0),
//             topRight: Radius.circular(25.0),
//           ),
//           child: (sharedPrefsClient.accessToken != "") && showBottomNavBar
//               ? BottomNavigationBar(
//                   key: _bottomNavigationKey,
//                   unselectedFontSize: 14,
//                   selectedFontSize: 14,
//                   showUnselectedLabels: true,
//                   items: sharedPrefsClient.accessToken != ""
//                       ? [
//                           BottomNavigationBarItem(
//                             icon: svgIcon("home"),
//                             activeIcon: svgIcon("home_selected"),
//                             label: AppLocalization.of(context)
//                                 .getTranslatedValues("home"),
//                           ),
//                           BottomNavigationBarItem(
//                             icon: svgIcon("services"),
//                             activeIcon: svgIcon("services_selected"),
//                             label: AppLocalization.of(context)
//                                 .getTranslatedValues("services"),
//                           ),
//                           BottomNavigationBarItem(
//                             icon: svgIcon("help"),
//                             activeIcon: svgIcon("help_selected"),
//                             label: AppLocalization.of(context)
//                                 .getTranslatedValues("help"),
//                           ),
//                           BottomNavigationBarItem(
//                             icon: svgIcon("more"),
//                             activeIcon: svgIcon("more_selected"),
//                             label: AppLocalization.of(context)
//                                 .getTranslatedValues("more"),
//                           ),
//                           BottomNavigationBarItem(
//                             icon: svgIcon("settings"),
//                             activeIcon: svgIcon("settings_selected"),
//                             label: AppLocalization.of(context)
//                                 .getTranslatedValues("setting"),
//                           ),
//                         ]
//                       : [
//                           BottomNavigationBarItem(
//                             icon: svgIcon("help"),
//                             activeIcon: svgIcon("help_selected"),
//                             label: AppLocalization.of(context)
//                                 .getTranslatedValues("help"),
//                           ),
//                           BottomNavigationBarItem(
//                             icon: svgIcon("near_me"),
//                             activeIcon: svgIcon("near_me_selected"),
//                             label: AppLocalization.of(context)
//                                 .getTranslatedValues("nearMe"),
//                           ),
//                           BottomNavigationBarItem(
//                             icon: svgIcon("sign_in"),
//                             activeIcon: svgIcon("sign_in_selected"),
//                             label: AppLocalization.of(context)
//                                 .getTranslatedValues("signIn"),
//                           ),
//                           BottomNavigationBarItem(
//                             icon: svgIcon("guidelines"),
//                             activeIcon: svgIcon("guidelines_selected"),
//                             label: AppLocalization.of(context)
//                                 .getTranslatedValues("guidelines"),
//                           ),
//                           BottomNavigationBarItem(
//                             icon: svgIcon("about"),
//                             activeIcon: svgIcon("about_selected"),
//                             label: AppLocalization.of(context)
//                                 .getTranslatedValues("about"),
//                           ),
//                         ],
//                   currentIndex: selectedTab,
//                   onTap: (value) {
//                     if (value == 1 &&
//                         !Navigator.canPop(context) &&
//                         selectedTab != 1) {}
//                     if (value == selectedTab) {
//                       CustomNavigator.popInSubNavigator();
//                     } else {
//                       setState(() {
//                         selectedTab = value;
//                       });
//                     }
//                   },
//                 )
//               : null,
//         ),
//       ),
//     );
//   }
// }
import 'package:ebook/core/resources/assets_manager.dart';
import 'package:ebook/core/resources/color_manager.dart';
import 'package:ebook/core/resources/styles_manager.dart';
import 'package:ebook/features/sign_in/presentation/pages/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/navigation/custom_navigation.dart';
import '../../core/resources/app_localization.dart';
import '../../core/resources/routes_manager.dart';
import '../../injection_container.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

int selectedTab = 0;
bool showBottomNavBar = true;

class _MainScreenState extends State<MainScreen> {
  final GlobalKey _bottomNavigationKey = GlobalKey();

  late List<Widget> appPageTab;
  Permission notification = Permission.notification;

  @override
  void initState() {
    super.initState();

    CustomNavigator.navigatorKeysBottomNav = [
      GlobalKey<NavigatorState>(),
      GlobalKey<NavigatorState>(),
      GlobalKey<NavigatorState>(),
      GlobalKey<NavigatorState>(),
      GlobalKey<NavigatorState>(),
    ];
    selectedTab = sharedPrefsClient.accessToken != "" ? 0 : 2;

    appPageTab = sharedPrefsClient.accessToken != ""
        ? [
            Navigator(
                key: CustomNavigator.navigatorKeysBottomNav[0],
                initialRoute: Routes.booksRoute,
                onGenerateRoute: CustomNavigator.generateHomeRoute
                //generateHomeRoute,
                ),
            Navigator(
                key: CustomNavigator.navigatorKeysBottomNav[1],
                initialRoute: Routes.quizRoute,
                onGenerateRoute: CustomNavigator.generateHomeRoute
                //generateHomeRoute,
                ),
            Navigator(
                key: CustomNavigator.navigatorKeysBottomNav[2],
                initialRoute: Routes.homeRoute,
                onGenerateRoute: CustomNavigator.onCreateRoute
                //generateHomeRoute,
                ),
            Navigator(
                key: CustomNavigator.navigatorKeysBottomNav[3],
                initialRoute: Routes.chatRoute,
                onGenerateRoute: CustomNavigator.generateHomeRoute
                //generateHomeRoute,
                ),
            Navigator(
                key: CustomNavigator.navigatorKeysBottomNav[4],
                initialRoute: Routes.profileRoute,
                onGenerateRoute: CustomNavigator.generateHomeRoute
                //generateHomeRoute,
                ),
          ]
        : [
            Navigator(
                key: CustomNavigator.navigatorKeysBottomNav[0],
                initialRoute: Routes.booksRoute,
                onGenerateRoute: CustomNavigator.generateHomeRoute
                //generateHomeRoute,
                ),
            Navigator(
                key: CustomNavigator.navigatorKeysBottomNav[1],
                initialRoute: Routes.quizRoute,
                onGenerateRoute: CustomNavigator.generateHomeRoute
                //generateHomeRoute,
                ),
            Navigator(
                key: CustomNavigator.navigatorKeysBottomNav[2],
                initialRoute: Routes.onBoardingRoute,
                onGenerateRoute: CustomNavigator.onCreateRoute
                //generateHomeRoute,
                ),
            Navigator(
                key: CustomNavigator.navigatorKeysBottomNav[3],
                initialRoute: Routes.chatRoute,
                onGenerateRoute: CustomNavigator.generateHomeRoute
                //generateHomeRoute,
                ),
            Navigator(
                key: CustomNavigator.navigatorKeysBottomNav[4],
                initialRoute: Routes.profileRoute,
                onGenerateRoute: CustomNavigator.onCreateRoute
                //generateHomeRoute,
                ),
          ];
  }

  @override
  Widget build(BuildContext context) {
    Widget svgIcon(String text) {
      return Padding(
        padding: EdgeInsets.only(bottom: 7.0.h),
        child: SvgPicture.asset(
          text,
          width: 24,
          height: 22,
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        final canPop = CustomNavigator
            .navigatorKeysBottomNav[selectedTab].currentState!
            .canPop();

        if (canPop) {
          CustomNavigator.popInSubNavigator();
        } else if ((sharedPrefsClient.accessToken != "") && selectedTab != 0) {
          selectedTab = 0;
        } else if (sharedPrefsClient.accessToken == "" && selectedTab != 2) {
          selectedTab = 2;
        } else {
          return true;
        }

        return false;
      },
      child: Scaffold(
        body: sharedPrefsClient.accessToken != ""
            ? IndexedStack(index: selectedTab, children: appPageTab)
            : Navigator(
                key: CustomNavigator.navigatorKeysBottomNav[2],
                initialRoute: Routes.onBoardingRoute,
                onGenerateRoute: CustomNavigator.onCreateRoute,
              ),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
          child: (sharedPrefsClient.accessToken != "") && showBottomNavBar
              ? BottomNavigationBar(
                  key: _bottomNavigationKey,
                  unselectedFontSize: 12,
                  selectedFontSize: 14,
                  unselectedItemColor: ColorManager.black,
                  backgroundColor: ColorManager.primary,
                  fixedColor: ColorManager.primary,
                  showUnselectedLabels: true,
                  items: sharedPrefsClient.accessToken != ""
                      ? [
                          BottomNavigationBarItem(
                            // backgroundColor: Colors.black,
                            icon: svgIcon(SvgAssets.readBook),
                            activeIcon: svgIcon(SvgAssets.readBook),
                            label:
                                AppLocalization.of(context).getTranslatedValues(
                              "my_room",
                            ),
                          ),
                          BottomNavigationBarItem(
                            icon: svgIcon(SvgAssets.readBook),
                            activeIcon: svgIcon(SvgAssets.readBook),
                            label: AppLocalization.of(context)
                                .getTranslatedValues("my_books"),
                          ),
                          BottomNavigationBarItem(
                            icon: svgIcon(SvgAssets.readBook),
                            activeIcon: svgIcon(SvgAssets.readBook),
                            label: AppLocalization.of(context)
                                .getTranslatedValues("my_records"),
                          ),
                          BottomNavigationBarItem(
                            icon: svgIcon(SvgAssets.readBook),
                            activeIcon: svgIcon(SvgAssets.readBook),
                            label: AppLocalization.of(context)
                                .getTranslatedValues("favorite"),
                          ),
                          BottomNavigationBarItem(
                            icon: svgIcon(SvgAssets.readBook),
                            activeIcon: svgIcon(SvgAssets.readBook),
                            label: AppLocalization.of(context)
                                .getTranslatedValues("my_profile"),
                          ),
                        ]
                      : [
                          BottomNavigationBarItem(
                            icon: svgIcon(SvgAssets.readBook),
                            activeIcon: svgIcon(SvgAssets.readBook),
                            label: AppLocalization.of(context)
                                .getTranslatedValues("my_room"),
                          ),
                          BottomNavigationBarItem(
                            icon: svgIcon(SvgAssets.readBook),
                            activeIcon: svgIcon(SvgAssets.readBook),
                            label: AppLocalization.of(context)
                                .getTranslatedValues("my_books"),
                          ),
                          BottomNavigationBarItem(
                            icon: svgIcon(SvgAssets.readBook),
                            activeIcon: svgIcon(SvgAssets.readBook),
                            label: AppLocalization.of(context)
                                .getTranslatedValues("my_records"),
                          ),
                          BottomNavigationBarItem(
                            icon: svgIcon(SvgAssets.readBook),
                            activeIcon: svgIcon(SvgAssets.readBook),
                            label: AppLocalization.of(context)
                                .getTranslatedValues("favorite"),
                          ),
                          BottomNavigationBarItem(
                            icon: svgIcon(SvgAssets.readBook),
                            activeIcon: svgIcon(SvgAssets.readBook),
                            label: AppLocalization.of(context)
                                .getTranslatedValues("my_profile"),
                          ),
                        ],
                  currentIndex: selectedTab,
                  onTap: (value) {
                    if (value == 1 &&
                        !Navigator.canPop(context) &&
                        selectedTab != 1) {
                      // context.read<CategorizationBloc>().add(CategorizationInit());
                    }
                    if (value == selectedTab) {
                      CustomNavigator.popInSubNavigator();
                    } else {
                      setState(() {
                        selectedTab = value;
                      });
                    }
                  },
                )
              : null,
        ),
      ),
    );
  }
}
