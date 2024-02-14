import 'dart:convert';
import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../features/sign_in/data/models/auth_response.dart';
import '../../features/sign_in/domain/entities/auth.dart';
import '../../injection_container.dart';
import '../blocs/app_bloc/app_bloc.dart';
import '../config/app_env.dart';
import '../resources/color_manager.dart';
import 'api_response_model.dart';
import 'api_url.dart';
import 'request_data.dart';

abstract class ISchoolRest {
  /// [NetworkLinks] field that swap between base url when [get] url.
  Future<ApiResponse> get(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    String? userToken,
  });

  Future<ApiResponse> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    String? userToken,
  });

  Future<ApiResponse> put(
    String url, {
    String? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    String? userToken,
  });

  Future<ApiResponse> delete(
    String url, {
    String? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    String? userToken,
  });

  Future<ApiResponse> download(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    String? userToken,
  });
}

class SchoolRest implements ISchoolRest {
  final Dio _dio;
  final AppEnvironment _appEnvironment;
  final bool enableLog;

  final Map<String, dynamic> _headers = {
    'Access-Control-Allow-Origin': '*',
    'Content-Type': 'application/json',
  };

  SchoolRest(this._dio, this._appEnvironment, {this.enableLog = false}) {
    switch (_appEnvironment) {
      case AppEnvironment.PRODUCTION:
        _dio.options.baseUrl = ApiURLs.baseUrl;
        _dio.options.headers = _headers;

        break;
      case AppEnvironment.STAGING:
        _dio.options.baseUrl = ApiURLs.baseUrl;
        _dio.options.headers = _headers;
        break;
    }
  }

  @override
  Future<ApiResponse> get(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    String? userToken,
  }) async {
    ApiResponse apiResponse = ApiResponse(pageNumber: 1);
    try {
      var requestData =
          _getRequestData(null, headers, queryParameters, userToken);
      requestData.headers.addAll({"lang": sharedPrefsClient.currentLanguage});
      _headers.addAll({"DeviceDate": DateTime.now().toIso8601String()});

      final Future<Response> getMethod = _dio.get(
        url,
        options: Options(headers: requestData.headers),
        queryParameters: requestData.params,
      );

      apiResponse = await _executeRequest(method: getMethod);
      return apiResponse;
    } on ApiResponse catch (e) {
      return e;
    }
  }

  @override
  Future<ApiResponse> delete(
    String url, {
    String? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    String? userToken,
  }) async {
    ApiResponse apiResponse = ApiResponse(pageNumber: 1);
    try {
      var requestData =
          _getRequestData(null, headers, queryParameters, userToken);
      requestData.headers.addAll({"lang": sharedPrefsClient.currentLanguage});
      _headers.addAll({"DeviceDate": DateTime.now().toIso8601String()});

      final Future<Response> getMethod = _dio.delete(url,
          options: Options(headers: requestData.headers),
          queryParameters: requestData.params,
          data: data);

      apiResponse = await _executeRequest(method: getMethod);

      return apiResponse;
    } on ApiResponse catch (e) {
      return e;
    }
  }

  @override
  Future<ApiResponse> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    String? userToken,
  }) async {
    ApiResponse apiResponse = ApiResponse(pageNumber: 1);
    try {
      var requestData =
          _getRequestData(data, headers, queryParameters, userToken);
      Map<String, dynamic>.from((requestData.headers))
          .addAll({"lang": sharedPrefsClient.currentLanguage});
      _headers.addAll({"DeviceDate": DateTime.now().toIso8601String()});

      final Future<Response> postMethod = _dio.post(
        url,
        data: requestData.data,
        options: Options(headers: requestData.headers),
        queryParameters: requestData.params,
      );

      apiResponse = await _executeRequest(method: postMethod);

      return apiResponse;
    } on ApiResponse catch (e) {
      return e;
    }
  }

  @override
  Future<ApiResponse> put(
    String url, {
    String? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    String? userToken,
  }) async {
    ApiResponse apiResponse = ApiResponse(pageNumber: 1);
    try {
      var requestData =
          _getRequestData(data, headers, queryParameters, userToken);
      requestData.headers.addAll({"lang": sharedPrefsClient.currentLanguage});
      _headers.addAll({"DeviceDate": DateTime.now().toIso8601String()});

      final Future<Response> putMethod = _dio.put(
        url,
        data: requestData.data,
        options: Options(headers: requestData.headers),
        queryParameters: requestData.params,
      );

      apiResponse = await _executeRequest(method: putMethod);
      return apiResponse;
    } on ApiResponse catch (e) {
      return e;
    }
  }

  @override
  Future<ApiResponse> download(String url,
      {Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters,
      String? userToken}) async {
    ApiResponse apiResponse = ApiResponse(pageNumber: 1);
    try {
      var requestData =
          _getRequestData(null, headers, queryParameters, userToken);
      requestData.headers.addAll({"lang": sharedPrefsClient.currentLanguage});
      _headers.addAll({"DeviceDate": DateTime.now().toIso8601String()});

      final Future<Response> getMethod = _dio.get(
        url,
        options: Options(
            headers: requestData.headers, responseType: ResponseType.bytes),
        queryParameters: requestData.params,
      );

      apiResponse = await _executeDownloadRequest(method: getMethod);

      return apiResponse;
    } on ApiResponse catch (e) {
      return e;
    }
  }

  RequestData _getRequestData(dynamic data, Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters, String? userToken) {
    Map<String, dynamic> requestHeads;

    if (headers == null) {
      requestHeads = _headers;
    } else {
      requestHeads = headers;
    }
    if (userToken != null && userToken != "") {
      requestHeads.addAll({'Authorization': "Bearer $userToken"});
    } else if (requestHeads.containsKey('Authorization')) {
      requestHeads.remove('Authorization');
    }
    _headers.addAll({"DeviceDate": DateTime.now().toIso8601String()});

    var requestData = RequestData(
      data: data ??= '',
      headers: requestHeads,
      params: queryParameters ??= {'': ''},
    );
    return requestData;
  }

  Future<ApiResponse> _executeRequest({
    required Future<Response> method,
  }) async {
    ApiResponse apiResponse = ApiResponse(pageNumber: 1);
    try {
      final response = await method;

      // apiResponse.statusCode = response.statusCode;
      apiResponse = ApiResponse.fromJson(response.data);
      // apiResponse = await response.data["data"];

      if (enableLog) _networkLog(response);
      return apiResponse;
    } on DioException catch (e) {
      _traceError(e);
      // apiResponse.statusCode =
      //     e.response == null ? 500 : e.response!.statusCode;
      if (e.response!.statusCode == 429) {
        currentContext!.read<AppBloc>().add(UpdateAuthAppEvent(
            userAuthStatus: UserAuthStatus.reachMaximumCall));
        await Fluttertoast.showToast(
            msg: e.response!.data,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorManager.darkPrimary,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (e.response!.statusCode == 404 ||
          e.response!.statusCode == 500) {
        currentContext!
            .read<AppBloc>()
            .add(UpdateAuthAppEvent(userAuthStatus: UserAuthStatus.signedOut));
        if (currentContext!.loaderOverlay.visible)
          currentContext!.loaderOverlay.hide();
        currentContext!.read<AppBloc>().add(
            UpdateAuthAppEvent(userAuthStatus: UserAuthStatus.serverError));

        throw Exception('unknown error with Refresh token');
        // throw Exception('Refresh token fail with 401');
      }
      if (e.response!.statusCode == 401 || e.response!.statusCode == 403) {
        sharedPrefsClient.accessToken = "";
        currentContext!.read<AppBloc>().add(UpdateAuthAppEvent(
            userAuthStatus: UserAuthStatus.userUnAuthorized));

        var headers = {
          "content-type": "application/json",
        };
        var body = {
          "refreshToken": sharedPrefsClient.refreshToken,
          "token": sharedPrefsClient.accessToken,
        };

        final tokenRes = await _dio.post(
          ApiURLs.refreshTokenPath,
          data: body,
          options: Options(headers: headers),
        );

        final tokenResponse = AuthResponse.fromJson(tokenRes.data);
        final domainTokenResponse = Auth(
          accessToken: tokenResponse.token!,
          refreshToken: tokenResponse.refreshToken!,
        );

        sharedPrefsClient.accessToken = domainTokenResponse.accessToken;
        sharedPrefsClient.refreshToken = domainTokenResponse.refreshToken;
      }
      apiResponse.data = e.response == null ? [] : e.response!.data;
      apiResponse = await e.response!.data["message"];
      throw apiResponse;
    }
  }

  Future<ApiResponse> _executeDownloadRequest({
    required Future<Response> method,
  }) async {
    ApiResponse apiResponse = ApiResponse(pageNumber: 1);
    try {
      final response = await method;
      // _apiResponse.statusCode = response.statusCode;
      apiResponse.data = response.data;

      // if (enableLog) response.data = base64Encode(_apiResponse.data!);
      if (enableLog) _networkLog(response);
      return apiResponse;
    } on DioException catch (e) {
      _traceError(e);
      // _apiResponse.statusCode =
      //     e.response == null ? 500 : e.response!.statusCode;
      apiResponse.data = e.response == null ? [] : e.response!.data;
      apiResponse = await e.response!.data["message"];
      return apiResponse;
    }
  }

  // Future<ApiResponse> _responseHandler(ApiResponse response) async {
  //   switch (response.) {
  //     case 200:
  //     case 201:
  //     case 204:
  //       return ApiResponse.fromJson(response.data);

  //     case 400:
  //       final String _errorHandler = response.data == null
  //           ? 'BadRequestException'
  //           : await _errorMessageHandler(response);
  //       break;
  //     case 404:
  //       final String _error = response.data == null
  //           ? 'NotFoundException'
  //           : response.data['message'] == null
  //               ? 'NotFoundException'
  //               : await _errorMessageHandler(response);
  //       throw NotFoundException(
  //         message: _error,
  //         messageKey: response.data['message'],
  //       );
  //     case 406:
  //       final String _error = response.data == null
  //           ? 'NotFoundException'
  //           : await _errorMessageHandler(response);
  //       throw NotFoundException(
  //         message: _error,
  //         messageKey: response.data['message'],
  //       );
  //     case 422:
  //       final String _error = response.data == null
  //           ? 'BadRequestException'
  //           : await _errorMessageHandler(response);
  //       throw BadRequestException(
  //         message: _error,
  //         messageKey: response.data['message'],
  //       );
  //     case 401:
  //       throw NotFoundException();
  //     case 403:
  //       final String _error = response.data == null
  //           ? 'UnAuthorizationException'
  //           : await _errorMessageHandler(response);
  //       throw UnAuthorizationException(message: _error);

  //     case 412:
  //       final String _error = response.data == null
  //           ? 'UnAuthorizationException'
  //           : await _errorMessageHandler(response);
  //       // ignore: use_build_context_synchronously
  //       currentContext!.read<AppBloc>().add(UpdateAuthAppEvent(
  //           userAuthStatus: UserAuthStatus.updateMobileDate));

  //       throw UnAuthorizationException(message: _error);

  //     case 500:
  //       final String _error = response.data == null
  //           ? 'ServerException'
  //           : await _errorMessageHandler(response);
  //       throw ServerException(message: _error);
  //     default:
  //       final String _error = response.data == null
  //           ? 'SocketException'
  //           : await _errorMessageHandler(response);
  //       throw const SocketException('There is no Internet!');
  //   }
  //   throw const SocketException('There is no Internet!');
  // }

  Future<String> _errorMessageHandler(ApiResponse response) async {
    final message =
        response.data is Map ? response.errors![0] : "error_message";
    return message;
  }

  void _traceError(DioException e) {
    String trace = '════════════════════════════════════════ \n'
        '╔╣ Dio [ERROR] info ==> \n'
        '╟ BASE_URL: ${e.requestOptions.baseUrl}\n'
        '╟ PATH: ${e.requestOptions.path}\n'
        '╟ Method: ${e.requestOptions.method}\n'
        '╟ Params: ${e.requestOptions.queryParameters}\n'
        '╟ Body: ${e.requestOptions.data}\n'
        '╟ Header: ${e.requestOptions.headers}\n'
        '╟ statusCode: ${e.response == null ? null : e.response!.statusCode}\n'
        '╟ RESPONSE: ${e.response == null ? null : e.response!.data} \n'
        '╟ stackTrace: ${e.stackTrace} \n'
        '╚ [END] ════════════════════════════════════════╝';
    developer.log(trace);
    // FirebaseAnalytics.instance.logEvent(
    //   name: 'network_log_error',
    //   parameters: {
    //     "api": trace,
    //   },
    // );
  }

  void _networkLog(Response response) {
    String trace = '════════════════════════════════════════ \n'
        '╔╣ Dio [RESPONSE] info ==> \n'
        '╟ BASE_URL: ${response.requestOptions.baseUrl}\n'
        '╟ PATH: ${response.requestOptions.path}\n'
        '╟ Method: ${response.requestOptions.method}\n'
        '╟ Params: ${response.requestOptions.queryParameters}\n'
        '╟ Body: ${response.requestOptions.data}\n'
        '╟ Header: ${response.requestOptions.headers}\n'
        '╟ statusCode: ${response.statusCode}\n'
        '╟ RESPONSE: ${jsonEncode(response.data)} \n'
        '╚ [END] ════════════════════════════════════════╝';
    developer.log(trace);
    // FirebaseAnalytics.instance.logEvent(
    //   name: 'network_log',
    //   parameters: {
    //     "api": trace,
    //   },
    // );
  }
}
