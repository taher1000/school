import 'package:ebook/core/resources/assets_manager.dart';
import 'package:ebook/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/enums/user_role.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/resources/app_localization.dart';
import '../../../../core/resources/routes_manager.dart';
import '../../../../injection_container.dart';

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
    selectedTab = 0;

    appPageTab = sharedPrefsClient.userRole == UserRole.teacher.value
        ? [
            Navigator(
                key: CustomNavigator.navigatorKeysBottomNav[0],
                initialRoute: Routes.homeRoute,
                onGenerateRoute: CustomNavigator.generateHomeRoute
                //generateHomeRoute,
                ),
            Navigator(
                key: CustomNavigator.navigatorKeysBottomNav[1],
                initialRoute: Routes.booksRoute,
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
                initialRoute: Routes.myTeacherProfileRoute,
                onGenerateRoute: CustomNavigator.generateHomeRoute
                //generateHomeRoute,
                ),
          ]
        : [
            Navigator(
                key: CustomNavigator.navigatorKeysBottomNav[0],
                initialRoute: Routes.studentMyBooksRoute,
                onGenerateRoute: CustomNavigator.generateHomeRoute
                //generateHomeRoute,
                ),
            Navigator(
                key: CustomNavigator.navigatorKeysBottomNav[1],
                initialRoute: Routes.studentMyAssignmentsRoute,
                onGenerateRoute: CustomNavigator.generateHomeRoute
                //generateHomeRoute,
                ),
            Navigator(
                key: CustomNavigator.navigatorKeysBottomNav[2],
                initialRoute: Routes.myFavoriteBooksRoute,
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
                initialRoute: Routes.myStudentProfileRoute,
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
                  unselectedIconTheme: IconThemeData(size: 22),
                  unselectedLabelStyle: TextStyle(color: ColorManager.grey1),
                  fixedColor: ColorManager.darkPrimary,
                  showUnselectedLabels: true,
                  items: sharedPrefsClient.userRole == UserRole.teacher.value
                      ? [
                          BottomNavigationBarItem(
                            // backgroundColor: Colors.black,
                            backgroundColor: ColorManager.secondryLight,
                            icon: FaIcon(FontAwesomeIcons.houseUser,
                                color: ColorManager.grey),
                            activeIcon: FaIcon(FontAwesomeIcons.houseUser),
                            label:
                                AppLocalization.of(context).getTranslatedValues(
                              "my_room",
                            ),
                          ),
                          BottomNavigationBarItem(
                            icon: FaIcon(
                                color: ColorManager.grey,
                                FontAwesomeIcons.book),
                            activeIcon: FaIcon(FontAwesomeIcons.book),
                            label: AppLocalization.of(context)
                                .getTranslatedValues("my_books"),
                          ),
                          BottomNavigationBarItem(
                            icon: FaIcon(
                                color: ColorManager.grey,
                                FontAwesomeIcons.microphone),
                            activeIcon: FaIcon(FontAwesomeIcons.microphone),
                            label: AppLocalization.of(context)
                                .getTranslatedValues("my_records"),
                          ),
                          BottomNavigationBarItem(
                            icon: FaIcon(
                                color: ColorManager.grey,
                                FontAwesomeIcons.bookBookmark),
                            activeIcon: FaIcon(FontAwesomeIcons.bookBookmark),
                            label: AppLocalization.of(context)
                                .getTranslatedValues("favorite"),
                          ),
                          BottomNavigationBarItem(
                            icon: FaIcon(
                                color: ColorManager.grey,
                                FontAwesomeIcons.solidUser),
                            activeIcon: FaIcon(FontAwesomeIcons.solidUser),
                            label: AppLocalization.of(context)
                                .getTranslatedValues("my_profile"),
                          ),
                        ]
                      : [
                          BottomNavigationBarItem(
                            icon: FaIcon(FontAwesomeIcons.book,
                                color: ColorManager.darkGreyText),
                            activeIcon: FaIcon(FontAwesomeIcons.book),
                            label: AppLocalization.of(context)
                                .getTranslatedValues("my_books"),
                          ),
                          BottomNavigationBarItem(
                            icon: FaIcon(FontAwesomeIcons.solidAddressBook,
                                color: ColorManager.darkGreyText),
                            activeIcon:
                                const FaIcon(FontAwesomeIcons.solidAddressBook),
                            label: AppLocalization.of(context)
                                .getTranslatedValues("my_assignments"),
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
