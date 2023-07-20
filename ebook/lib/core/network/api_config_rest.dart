import 'dart:convert';

import 'package:dio/dio.dart';
import 'dart:developer' as developer;

import 'package:ebook/core/network/api_url.dart';

abstract class IApiConfigRest {
  /// [NetworkLinks] field that swap between base url when [get] url.
  Future<Response> getApiConfig(String versionCode);
}

class ApiConfigRest implements IApiConfigRest {
  final Dio _dio;
  final bool enableLog;

  final Map<String, dynamic> _headers = {
    'Content-Type': 'application/json',
  };

  ApiConfigRest(this._dio, {this.enableLog = true}) {
    _dio.options.baseUrl = ApiURLs.baseUrl;
    _dio.options.headers = _headers;
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
        '╟ statusCode: ${e.response!.statusCode}\n'
        '╟ RESPONSE: ${e.response!.data} \n'
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
        '╟ RESPONSE: ${response.data} \n'
        '╚ [END] ════════════════════════════════════════╝';
    developer.log(trace);
    // FirebaseAnalytics.instance.logEvent(
    //   name: 'network_log',
    //   parameters: {
    //     "api": trace,
    //   },
    // );
  }

  @override
  Future<Response> getApiConfig(String versionCode) async {
    try {
      var body = jsonEncode({
        "versionCode": versionCode,
      });
      final getMethod =
          await _dio.post("Categorization/GetApiConfig", data: body);
      if (enableLog) _networkLog(getMethod);
      return getMethod;
    } on DioError catch (e) {
      _traceError(e);
      rethrow;
    }
  }
}
