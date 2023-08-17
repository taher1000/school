// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i4;

import '../../../../core/config/shared_prefs_client.dart' as _i5;
import 'app_module.dart' as _i31; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $inject(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final appModule = _$AppModule();
  gh.factory<_i3.BaseOptions>(() => appModule.dioOption());
  gh.singleton<_i4.Logger>(appModule.logger());
  gh.singleton<_i3.Dio>(
    appModule.dio(
      get<_i3.BaseOptions>(),
      // get<_i4.Logger>(),
      get<_i5.SharedPrefsClient>(),
    ),
    instanceName: 'BaseDio',
  );

  return get;
}

class _$AppModule extends _i31.AppModule {}
