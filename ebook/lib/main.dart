import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ebook/core/widgets/main_info_container.dart';
import 'package:ebook/features/home/presentation/pages/home_screen.dart';
import 'package:ebook/features/main/main_screen.dart';
import 'package:ebook/features/main/splash_screen.dart';
import 'package:ebook/features/sign_in/presentation/pages/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/blocs/app_bloc/app_bloc.dart';
import 'core/blocs/app_theme_cubit/app_theme_cubit.dart';
import 'core/blocs/bloc_config/bloc_observer.dart';
import 'core/blocs/language_cubit/language_cubit.dart';
import 'core/navigation/custom_navigation.dart';
import 'core/resources/app_localization.dart';
import 'core/resources/assets_manager.dart';
import 'core/resources/routes_manager.dart';
import 'core/resources/theme_manager.dart';
import 'core/widgets/popup/no_internet_pop_message.dart';
import 'core/widgets/popup/privacy_pop_message.dart';
import 'features/profile/presentation/pages/profile_screen.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await (Connectivity().checkConnectivity());
  await DependencyInjectionInit().registerSingletons();

  Bloc.observer = AppBlocObserver();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        splitScreenMode: true,
        designSize: const Size(414, 896),
        builder: (BuildContext context, Widget? child) => Listener(
              onPointerDown: (_) async {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus &&
                    currentFocus.focusedChild != null) {
                  await Future.delayed(const Duration(milliseconds: 50));
                  currentFocus.focusedChild?.unfocus();
                }
              },
              child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'School',
                  theme: getApplicationTheme(),
                  // themeMode: themeState.themeMode,
                  navigatorKey: CustomNavigator.navigatorState,
                  onGenerateRoute: CustomNavigator.onCreateRoute,
                  navigatorObservers: [CustomNavigator.routeObserver],
                  localizationsDelegates: const [
                    AppLocalization.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: const [
                    Locale('en', ''),
                    Locale('ar', ''),
                  ],
                  builder: (_, c) => HomeScreen()
                  //SplashScreen(),
                  ),
            ));
    // BlocProvider(
    //   create: (_) => AppBloc(
    //     getIt(),
    //   ),
    // child:

    //   setupDependencies(
    //     child: BlocBuilder<LanguageCubit, LanguageState>(
    //       buildWhen: (previousState, currentState) =>
    //           previousState != currentState,
    //       builder: (_, localeState) {
    //         return BlocBuilder<AppThemeCubit, AppThemeState>(
    //           builder: (_, themeState) {
    // return ScreenUtilInit(
    //     splitScreenMode: true,
    //     designSize: const Size(414, 896),
    //     builder: (BuildContext context, Widget? child) => Listener(
    //           onPointerDown: (_) async {
    //             FocusScopeNode currentFocus =
    //                 FocusScope.of(context);
    //             if (!currentFocus.hasPrimaryFocus &&
    //                 currentFocus.focusedChild != null) {
    //               await Future.delayed(
    //                   const Duration(milliseconds: 50));
    //               currentFocus.focusedChild?.unfocus();
    //             }
    //           },
    //           child: MaterialApp(
    //               debugShowCheckedModeBanner: false,
    //               title: 'EZENESS',
    //               theme: getApplicationTheme(),
    //               themeMode: themeState.themeMode,
    //               navigatorKey: CustomNavigator.navigatorState,
    //               onGenerateRoute: CustomNavigator.onCreateRoute,
    //               navigatorObservers: [
    //                 CustomNavigator.routeObserver
    //               ],
    //               localizationsDelegates: const [
    //                 AppLocalization.delegate,
    //                 GlobalMaterialLocalizations.delegate,
    //                 GlobalWidgetsLocalizations.delegate,
    //                 GlobalCupertinoLocalizations.delegate,
    //               ],
    //               supportedLocales: const [
    //                 Locale('en', ''),
    //                 Locale('ar', ''),
    //               ],
    //               builder: (_, c) =>
    //               _AppBuilder(c),
    //               ),
    //         ));
    //           },
    //         );
    //       },
    //     ),
    //   ),
    // );
  }
}

class _AppBuilder extends StatefulWidget {
  final Widget? child;

  const _AppBuilder(this.child);

  @override
  State<_AppBuilder> createState() => _AppBuilderState();
}

class _AppBuilderState extends State<_AppBuilder> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
        // MainScreen();
        BlocListener<AppBloc, AppState>(
      listener: (context, state) async {
        if (state is UserAuthState) {
          switch (state.userAuthStatus) {
            /// SignedIn Status
            case UserAuthStatus.signedIn:
              CustomNavigator.push(Routes.mainRoute, clean: true);
              break;

            /// SignedIn Status

            /// Signed out Status
            case UserAuthStatus.signedOut:
              await sharedPrefsClient.clearUserData();

              CustomNavigator.push(Routes.mainRoute, clean: true);
              break;

            /// User need force update

            /// First Time as a Login for User
            case UserAuthStatus.firstTimeLogin:
              CustomNavigator.push(Routes.mainRoute, clean: true);
              break;

            /// User has no internet connection.
            case UserAuthStatus.userHasNoInternetConnection:
              showDialog(
                  useSafeArea: false,
                  context: currentContext!,
                  builder: (context) => const NoInternetPopMessage(),
                  barrierDismissible: false);
              break;

            /// User Should Agree Privacy
            case UserAuthStatus.userShouldAgreePrivacy:
              showCupertinoModalPopup(
                  context: currentContext!,
                  builder: (context) => const PrivacyPopMessage(),
                  barrierDismissible: false);
              break;

            /// User Should Agree Privacy
            case UserAuthStatus.userAgreePrivacyMessage:
              CustomNavigator.pop();
              break;
            case UserAuthStatus.userNeedUpdate:
              // TODO: Handle this case.
              break;
            case UserAuthStatus.updateMobileDate:
              // TODO: Handle this case.
              break;
          }
        }
      },
      child: widget.child,
    );
  }
}
