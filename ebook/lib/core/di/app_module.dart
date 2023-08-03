import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:ebook/core/config/shared_prefs_client.dart';

@module
abstract class AppModule {
  BaseOptions dioOption() => BaseOptions(
        baseUrl: '',
        connectTimeout: Duration(seconds: 40),
        receiveTimeout: Duration(seconds: 40),
        responseType: ResponseType.plain,
        headers: <String, String>{
          'Accept': 'application/json',
          'Connection': 'keep-alive',
        },
      );

  @Named(InjectableInstanceName.dio)
  @singleton
  Dio dio(
      BaseOptions option, Logger logger, SharedPrefsClient prefsRepository) {
    final Dio dio = Dio(option);
    return dio
      ..interceptors.addAll(
        <Interceptor>[
          // TokensManagerInterceptor(baseDio: dio, prefsRepository: prefsRepository, logger: logger),
          LogInterceptor(
            requestBody: true,
            responseBody: true,
            responseHeader: true,
            requestHeader: true,
            request: true,
            // logPrint: (message) => logger.i(message),
          ),
        ],
      );
  }

  @singleton
  Logger logger() => Logger(
        printer: PrettyPrinter(),
        //TODO(abd): add flavor support
        level: kReleaseMode ? Level.warning : Level.verbose,
        // TODO(abd): implement firebase output to support server log
        output: kReleaseMode ? ConsoleOutput() : ConsoleOutput(),
      );
}

abstract class InjectableInstanceName {
  InjectableInstanceName._();

  static const dio = 'BaseDio';
}
