import 'dart:async';
import 'dart:developer' as developer;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_container.dart';
import '../../config/app_env.dart';
import '../../config/shared_prefs_client.dart';
import '../../navigation/custom_navigation.dart';
import '../../network/api_url.dart';
import '../../resources/routes_manager.dart';
import '../../widgets/api_config_message.dart';
import '../../widgets/popup/no_internet_pop_message.dart';
import '../app_theme_cubit/app_theme_cubit.dart';
import '../language_cubit/language_cubit.dart';

// import 'package:tawqi3i_packages/tawqi3i_packages.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  AppBloc(SharedPrefsClient prefsClient) : super(AppInitial()) {
    /// Init App Functions
    on<InitApp>((event, emit) async {
      try {
        // PackageInfo packageInfo = await PackageInfo.fromPlatform();
        // var result = await _getApiConfig(getIt(), packageInfo.buildNumber);
        if (true) {
          // developer.log('BASE_URLS : ${jsonEncode(BASE_URLS.toJson())}');
          final appEnv = AppEnvironment.STAGING;
          await getIt.reset(dispose: true);
          await DependencyInjectionInit().registerSingletons();
          // await inject();
          String baseUrl = (appEnv == AppEnvironment.PRODUCTION
                  ? ApiURLs.baseUrl
                  : ApiURLs.baseUrl)
              .replaceAll("https://", '')
              .replaceAll("http://", '');

          CustomNavigator.push(Routes.mainRoute, clean: true);
          // await _isForceUpdate(packageInfo).then((value) {
          //   if (value) {
          //     emit(UserAuthState(UserAuthStatus.userNeedUpdate));
          //   } else {
          //     checkInternet();
          //   }
          // });
        } else {
          developer.log('BASE_URLS :no data');
          showDialog(
            useSafeArea: false,
            context: currentContext!,
            builder: (context) {
              return const ApiConfigMessage();
            },
            barrierDismissible: false,
          ).then((value) => add(InitApp()));
        }
      } on Exception catch (_) {
        checkInternet();
      }
    });

    add(InitApp());

    on<UpdateAuthAppEvent>((event, emit) async {
      emit(UserAuthState(event.userAuthStatus!));
    });
  }

  // Future<bool> _getApiConfig(ApiConfigRest rest, String versionCode) async {
  //   try {
  //     var response = await rest.getApiConfig(versionCode);
  //     ApiResponse apiResponse = ApiResponse.fromJson(response.data);
  //     if (apiResponse.statusCode == 200) {
  //       var apiConfigData = AesAlgorithm.decryption(
  //           apiResponse.data[0]["data"], apiResponse.data[0]["iv"]);
  //       BASE_URLS = NetworkLinks.fromJson(jsonDecode(apiConfigData));
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     return false;
  //   }
  // }

  void _changeLanguageCached(String language) {
    if (language == "ar") {
      currentContext!.read<LanguageCubit>().toArabic();
    } else {
      currentContext!.read<LanguageCubit>().toEnglish();
    }
  }

  void _changeAppTheme(ThemeMode mode) {
    currentContext!.read<AppThemeCubit>().changeTheme(mode);
  }

  void toggleTheme(ThemeMode mode) {
    _changeAppTheme(mode);
  }

  void toggleLanguage(String language) {
    _changeLanguageCached(language);
  }

  // Future<bool> _isForceUpdate(PackageInfo packageInfo) async {
  //   var response = await getIt<AppUseCases>().getAppSettings();

  //   var data = response.fold((l) => false, (appSettings) {
  //     developer.log('buildNumber : ${packageInfo.buildNumber}');
  //     developer.log('packageName : ${packageInfo.packageName}');
  //     if (!sharedPrefsClient.isGMS) {
  //       if (!(int.parse(packageInfo.buildNumber) >= appSettings.huawei)) {
  //         return true;
  //       }
  //     } else if (Platform.isAndroid) {
  //       if (!(int.parse(packageInfo.buildNumber) >= appSettings.android)) {
  //         return true;
  //       }
  //     } else {
  //       if (!(int.parse(packageInfo.buildNumber) >= appSettings.ios)) {
  //         return true;
  //       }
  //     }
  //   });
  //   return data ?? false;
  // }

  void checkInternet() {
    BuildContext? noInternetContext;
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      developer.log("result: $result");

      if (result == ConnectivityResult.none) {
        if (noInternetContext == null) {
          showDialog(
              useSafeArea: false,
              context: currentContext!,
              builder: (context) {
                noInternetContext = context;
                return const NoInternetPopMessage();
              },
              barrierDismissible: false);
        }
      } else {
        if (Navigator.of(currentContext!).canPop()) {
          try {
            Navigator.of(currentContext!).pop();
            noInternetContext = null;
          } catch (_) {}
        }
      }
    });
  }
}
