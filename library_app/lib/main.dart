import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'core/resources/color_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:firebase_core/firebase_core.dart';

import 'core/blocs/app_bloc/app_bloc.dart';
import 'core/blocs/app_theme_cubit/app_theme_cubit.dart';
import 'core/blocs/bloc_config/bloc_observer.dart';
import 'core/blocs/language_cubit/language_cubit.dart';
import 'core/di/injectable.dart';
import 'core/navigation/custom_navigation.dart';
import 'core/network/my_http_overrides.dart';
import 'core/resources/app_localization.dart';
import 'core/resources/routes_manager.dart';
import 'core/resources/theme_manager.dart';
import 'core/widgets/popup/no_internet_pop_message.dart';
import 'core/widgets/popup/privacy_pop_message.dart';
import 'features/books/presentation/pages/books_screen.dart';
import 'features/sign_in/presentation/pages/sign_in_screen.dart';
import 'injection_container.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  HttpOverrides.global = MyHttpOverrides();
  await (Connectivity().checkConnectivity());
  await DependencyInjectionInit().registerSingletons();
  await inject();
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
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppBloc(
        getIt(),
      ),
      child: setupDependencies(
        child: BlocBuilder<LanguageCubit, LanguageState>(
          buildWhen: (previousState, currentState) =>
              previousState != currentState,
          builder: (_, localeState) {
            return BlocBuilder<AppThemeCubit, AppThemeState>(
                builder: (_, themeState) {
              return DevicePreview(
                  enabled: false,
                  builder: (context) => ScreenUtilInit(
                        splitScreenMode: true,
                        designSize: const Size(414, 896),
                        builder: (BuildContext context, Widget? child) =>
                            Listener(
                          onPointerDown: (_) async {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus &&
                                currentFocus.focusedChild != null) {
                              await Future.delayed(
                                  const Duration(milliseconds: 50));
                              currentFocus.focusedChild?.unfocus();
                            }
                          },
                          child: MaterialApp(
                            debugShowCheckedModeBanner: false,
                            title: 'School App',
                            theme: getApplicationTheme(),
                            darkTheme: getApplicationDarkTheme(),
                            locale: localeState.locale,
                            themeMode: themeState.themeMode,
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
                              Locale('ar', ''),
                              Locale('en', ''),
                            ],
                            builder: (_, c) => LoaderOverlay(
                                useDefaultLoading: false,
                                overlayOpacity: 0.5,
                                overlayWidget: Center(
                                  child: SpinKitCubeGrid(
                                    color: ColorManager.darkPrimary,
                                    size: 50.0,
                                  ),
                                ),
                                child: _AppBuilder(c)),
                          ),
                        ),
                      ));
            });
          },
        ),
      ),
    );
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
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
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
              CustomNavigator.push(Routes.loginRoute, clean: true);

              break;

            /// User need force update
            case UserAuthStatus.userNeedUpdate:
              CustomNavigator.push(Routes.loginRoute, clean: true);
              break;

            /// First Time as a Login for User
            case UserAuthStatus.firstTimeLogin:
              CustomNavigator.push(
                  sharedPrefsClient.firstTimeLogin
                      ? Routes.onBoardingRoute
                      : Routes.loginRoute,
                  clean: true);
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

            /// User Should update phone date
            case UserAuthStatus.updateMobileDate:
              CustomNavigator.push(Routes.onBoardingRoute, clean: true);
              break;
            case UserAuthStatus.reachMaximumCall:
              context.loaderOverlay.hide();
              break;
            case UserAuthStatus.userUnAuthorized:
              context.loaderOverlay.hide();

              context.read<AppBloc>().add(
                  UpdateAuthAppEvent(userAuthStatus: UserAuthStatus.signedOut));
              break;
          }
        }
      },
      child: widget.child,
    );
  }
}
