import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../injection_container.dart';
import '../config/app_env.dart';
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
        _dio.options.baseUrl = "${ApiURLs.baseUrl}";
        _dio.options.headers = _headers;

        break;
      case AppEnvironment.STAGING:
        _dio.options.baseUrl = "${ApiURLs.baseUrl}";
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
    ApiResponse _apiResponse = ApiResponse(pageNumber: 1);
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

      _apiResponse = await _executeRequest(method: getMethod);

      return _apiResponse;
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
    ApiResponse _apiResponse = ApiResponse(pageNumber: 1);
    try {
      var requestData =
          _getRequestData(null, headers, queryParameters, userToken);
      requestData.headers.addAll({"lang": sharedPrefsClient.currentLanguage});
      _headers.addAll({"DeviceDate": DateTime.now().toIso8601String()});

      final Future<Response> getMethod = _dio.delete(url,
          options: Options(headers: requestData.headers),
          queryParameters: requestData.params,
          data: data);

      _apiResponse = await _executeRequest(method: getMethod);

      return _apiResponse;
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
    ApiResponse _apiResponse = ApiResponse(pageNumber: 1);
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

      _apiResponse = await _executeRequest(method: postMethod);

      return _apiResponse;
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
    ApiResponse _apiResponse = ApiResponse(pageNumber: 1);
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

      _apiResponse = await _executeRequest(method: putMethod);
      return _apiResponse;
    } on ApiResponse catch (e) {
      return e;
    }
  }

  @override
  Future<ApiResponse> download(String url,
      {Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters,
      String? userToken}) async {
    ApiResponse _apiResponse = ApiResponse(pageNumber: 1);
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

      _apiResponse = await _executeDownloadRequest(method: getMethod);

      return _apiResponse;
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
    ApiResponse _apiResponse = ApiResponse(pageNumber: 1);
    try {
      final response = await method;
      // _apiResponse.statusCode = response.statusCode;
      _apiResponse = ApiResponse.fromJson(response.data);
      // _apiResponse = await response.data["data"];

      if (enableLog) _networkLog(response);
      return _apiResponse;
    } on DioError catch (e) {
      _traceError(e);
      // _apiResponse.statusCode =
      //     e.response == null ? 500 : e.response!.statusCode;
      _apiResponse.data = e.response == null ? [] : e.response!.data;
      _apiResponse = await e.response!.data["message"];
      throw _apiResponse;
    }
  }

  Future<ApiResponse> _executeDownloadRequest({
    required Future<Response> method,
  }) async {
    ApiResponse _apiResponse = ApiResponse(pageNumber: 1);
    try {
      final response = await method;
      // _apiResponse.statusCode = response.statusCode;
      _apiResponse.data = response.data;

      // if (enableLog) response.data = base64Encode(_apiResponse.data!);
      if (enableLog) _networkLog(response);
      return _apiResponse;
    } on DioError catch (e) {
      _traceError(e);
      // _apiResponse.statusCode =
      //     e.response == null ? 500 : e.response!.statusCode;
      _apiResponse.data = e.response == null ? [] : e.response!.data;
      _apiResponse = await e.response!.data["message"];
      return _apiResponse;
    }
  }

  // Future<ApiResponse> _responseHandler(ApiResponse response) async {
  //   switch (response.statusCode) {
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

  void _traceError(DioError e) {
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
