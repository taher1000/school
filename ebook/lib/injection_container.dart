import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/blocs/bloc_config/bloc_providers.dart';
import 'core/config/app_env.dart';
import 'core/config/shared_prefs_client.dart';
import 'core/network/api_config_rest.dart';
import 'core/network/idm_rest.dart';
import 'core/network/school_rest.dart';
import 'features/main/data/datasource/user_datasource.dart';
import 'features/main/data/datasource/user_profile_datasource.dart';
import 'features/main/data/repositories/user_profile_repository.dart';
import 'features/main/data/repositories/user_repository.dart';
import 'features/main/domain/repositories/user_profile_repository.dart';
import 'features/main/domain/repositories/user_repository.dart';
import 'features/main/domain/usecases/user_usecase.dart';
import 'features/sign_in/data/datasources/auth_datasource.dart';
import 'features/sign_in/data/repositories/auth_repository.dart';
import 'features/sign_in/domain/repositories/auth_repository.dart';
import 'features/sign_in/domain/usecases/auth_usecases.dart';

final GetIt getIt = GetIt.instance;
final SharedPrefsClient sharedPrefsClient = getIt();

Widget setupDependencies({required Widget child}) => listOfBlocProviders(child);

Widget setupDependenciesMainScreen({required Widget child}) =>
    listOfBlocProvidersForMainScreen(child);

class DependencyInjectionInit {
  static final DependencyInjectionInit _singleton = DependencyInjectionInit._();

  factory DependencyInjectionInit() => _singleton;

  DependencyInjectionInit._();

  /// Register the Basic Singleton
  Future<void> registerSingletons() async {
    getIt.registerLazySingleton(() => appEnv);

    /// create a instance of Shared Prefs classes.
    final sharedPreferences = await SharedPreferences.getInstance();
    final sharedPrefsClient = SharedPrefsClient(sharedPreferences);
    getIt.registerLazySingleton(() => sharedPreferences);
    getIt.registerLazySingleton(() => sharedPrefsClient);

    /// register Dio Package
    getIt.registerLazySingleton(() => Dio());
    final idmRest = IdmRest(getIt(), appEnv, enableLog: true);
    getIt.registerLazySingleton(() => idmRest);

    getIt.registerLazySingleton(() => Dio(), instanceName: "apiConfig");

    getIt.registerLazySingleton(() => Dio(), instanceName: "schoolDio");

    final apiConfig =
        ApiConfigRest(getIt.call(instanceName: "apiConfig"), enableLog: true);

    final schoolRest = SchoolRest(getIt.call(instanceName: "schoolDio"), appEnv,
        enableLog: true);

    getIt.registerLazySingleton(() => apiConfig);
    getIt.registerLazySingleton(() => SchoolRest);

    getIt.registerLazySingleton(() => Connectivity());

    //TODO: initiate use cases here

    final authUseCase = _initAuth(idmRest);
    getIt.registerLazySingleton(() => authUseCase);
    getIt.registerLazySingleton(() => schoolRest);
    final profileUseCase = _initProfile(idmRest, schoolRest);
    getIt.registerLazySingleton(() => profileUseCase);
  }
}

/// Init Subjects UseCases
AuthenticateUseCase _initAuth(IIDMRest idmRest) {
  IAuthRemoteDataSource authDatasource;
  IAuthRepository authRepository;

  authDatasource = AuthRemoteDataSource(idmRest);

  // init repositories
  authRepository = AuthRepository(authDatasource);

  // use cases
  return AuthenticateUseCase(authRepository);
}

/// Init Subjects UseCases
ProfileDataUseCase _initProfile(IIDMRest idmRest, ISchoolRest iSanadRest) {
  IProfileRemoteDataSource profileDatasource;
  IProfileRepository profileRepository;
  IUserRemoteDataSource userDatasource;
  IUserRepository userRepository;
  profileDatasource = ProfileRemoteDataSource(idmRest, iSanadRest);
  userDatasource = UserRemoteDataSource(iSanadRest);

  // init repositories
  profileRepository = ProfileRepository(profileDatasource);
  userRepository = UserRepository(userDatasource);
  // use cases
  return ProfileDataUseCase(profileRepository, userRepository);
}
