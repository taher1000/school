import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:library_app/core/network/api_url.dart';
import 'package:logger/logger.dart';

import '../../features/sign_in/data/models/auth_response.dart';
import '../../features/sign_in/domain/entities/auth.dart';
import '../config/shared_prefs_client.dart';
import '../data/tokens_options.dart';

class TokensManagerInterceptor extends Interceptor {
  TokensManagerInterceptor({
    required this.baseDio,
    required this.prefsRepository,
    required this.logger,
  });

  final SharedPrefsClient prefsRepository;
  final Dio baseDio;
  final Logger logger;

  // We use a new Dio(to avoid dead lock) instance to request refresh token.
  final Dio tokenDio = Dio()
    ..interceptors.addAll([
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        requestHeader: true,
        request: true,
      ),
    ]);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final newOptions = addTokenToHeaderIfNeeded(options);
    handler.next(newOptions);
  }

  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    try {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.data);
      final int statusCode = jsonResponse['code'];

      switch (statusCode) {
        case 200:
          handler.next(response..data = jsonResponse);
          return;

        case 401:
          await refreshToken(
              response: response, handler: handler, jsonResponse: jsonResponse);
          return;

        default:
          handler.reject(
            DioException(
              requestOptions: response.requestOptions,
              response: response,
              error: jsonResponse['message'],
            ),
            true,
          );
          return;
      }
    } catch (ex, st) {
      logger.e('Dio OnResponse Unknown Error');
      handler.reject(
        DioException(
            requestOptions: response.requestOptions,
            response: response,
            error: ex),
        true,
      );
    }
  }

  RequestOptions addTokenToHeaderIfNeeded(RequestOptions options) {
    switch (TokenOptionsTypeExt.typeFrom(options)) {
      case TokenOptionsType.idm:
        options.headers['Authorization'] =
            'Bearer ' + prefsRepository.accessToken;
        break;

      case TokenOptionsType.sanad:
        throw UnimplementedError('sanad token handler need implement');

      case TokenOptionsType.none:
        break;
    }

    return options;
  }

  Future<void> refreshToken({
    required Response response,
    required ResponseInterceptorHandler handler,
    required Map<String, dynamic> jsonResponse,
  }) async {
    switch (TokenOptionsTypeExt.typeFrom(response.requestOptions)) {
      case TokenOptionsType.idm:
        try {
          if (prefsRepository.accessToken.isEmpty ||
              prefsRepository.refreshToken.isEmpty) {
            throw Exception('Refresh token fail with null token in prefs');
          }

          var headers = {
            "Content-Type": "application/x-www-form-urlencoded",
          };
          var body = {
            "grant_type": "refreshToken",
            "refreshToken": prefsRepository.refreshToken,
            'client_id': 'HrFZUo8o6dg4gUDzkYAi',
            'client_secret': 'k22DtPUNkpFbO3JqCDwn',
          };
          tokenDio.options = baseDio.options;

          final tokenRes = await tokenDio.post(
            ApiURLs.refreshTokenPath,
            data: body,
            options: Options(headers: headers),
          );

          if (tokenRes.statusCode != 200) {
            throw Exception('unknown error with Refresh token');
            // throw Exception('Refresh token fail with 401');
          }

          final tokenResponse =
              AuthResponse.fromJson(jsonDecode(tokenRes.data));
          final domainTokenResponse = Auth(
            accessToken: tokenResponse.token!,
            refreshToken: tokenResponse.refreshToken!,
          );

          prefsRepository.accessToken = domainTokenResponse.accessToken;
          prefsRepository.refreshToken = domainTokenResponse.refreshToken;

          // retry the original request
          final requestOptions = response.requestOptions;
          final requestOptionsWithToken =
              addTokenToHeaderIfNeeded(requestOptions);
          final Options newOptions = Options(
            contentType: requestOptions.contentType,
            extra: requestOptions.extra,
            followRedirects: requestOptions.followRedirects,
            headers: requestOptionsWithToken.headers,
            listFormat: requestOptions.listFormat,
            maxRedirects: requestOptions.maxRedirects,
            method: requestOptions.method,
            receiveDataWhenStatusError:
                requestOptions.receiveDataWhenStatusError,
            receiveTimeout: requestOptions.receiveTimeout,
            requestEncoder: requestOptions.requestEncoder,
            responseDecoder: requestOptions.responseDecoder,
            responseType: requestOptions.responseType,
            sendTimeout: requestOptions.sendTimeout,
            validateStatus: requestOptions.validateStatus,
          );

          final newResponse = await tokenDio.request(
            requestOptions.path,
            data: requestOptions.data,
            queryParameters: requestOptions.queryParameters,
            cancelToken: requestOptions.cancelToken,
            options: newOptions,
            onSendProgress: requestOptions.onSendProgress,
            onReceiveProgress: requestOptions.onReceiveProgress,
          );

          final Map<String, dynamic> jsonResponse =
              jsonDecode(newResponse.data);
          final int statusCode = jsonResponse['code'];

          if (statusCode == 200) {
            return handler.next(newResponse..data = jsonResponse);
          } else {
            handler.reject(
              DioException(
                requestOptions: response.requestOptions,
                response: response,
                error: jsonResponse['message'],
              ),
              true,
            );
          }
        } catch (ex, st) {
          logger.e('refresh token unknown error ex: $ex\nst: $st');
          // TODO(abd): add fallback behaviour
          // await prefsRepository.clearUserData();
          // App.navKey.currentState!.pushNamedAndRemoveUntil(LoginPage.route, (_) => false);
        }
        break;

      case TokenOptionsType.sanad:
      case TokenOptionsType.none:
        handler.reject(
          DioException(
            requestOptions: response.requestOptions,
            response: response,
            error: jsonResponse['message'],
          ),
          true,
        );
    }
  }
}
