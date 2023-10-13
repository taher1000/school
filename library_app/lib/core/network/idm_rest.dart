import 'dart:developer' as developer;
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import '../../features/sign_in/domain/params/auth_parameters.dart';
import '../../injection_container.dart';
import '../config/app_env.dart';
import 'api_url.dart';

abstract class IIDMRest {
  /// [NetworkLinks] field that swap between base url when [get] url.
  Future<Response> login(AuthParameters authParameters);

  Future<Response> refreshToken();

  Future<Response> getUserData();
}

class IdmRest implements IIDMRest {
  final Dio _dio;
  final AppEnvironment _appEnvironment;
  final bool enableLog;
  CookieJar cookieJar = CookieJar();

  final Map<String, dynamic> _headers = {"content-type": "application/json"};

  IdmRest(this._dio, this._appEnvironment, {this.enableLog = true}) {
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
  Future<Response> login(AuthParameters authParameters) async {
    try {
      _dio.interceptors.clear();
      var headers = {
        "content-type": "application/json",
      };
      var body = {
        "email": authParameters.email,
        "password": authParameters.password,
        "deviceId": authParameters.deviceId,
        "isAndroiodDevice": authParameters.isAndroidDevice,
      };

      final postMethod = await _dio.post(
        ApiURLs.loginPath,
        data: body,
        options: Options(
          headers: headers,
        ),
      );

      if (enableLog) _networkLog(postMethod);
      _dio.interceptors.clear();
      return postMethod;
    } on DioException catch (e) {
      _traceError(e);
      rethrow;
    }
  }

  @override
  Future<Response> refreshToken() async {
    try {
      var headers = {
        "content-type": "application/json",
      };
      var body = {
        "grant_type": "refreshToken",
        "refreshToken": sharedPrefsClient.refreshToken,
        // 'client_id': ApiURLs.idmClientId,
        // 'client_secret': BASE_URLS.idmClientSecret,
      };

      final postMethod = await _dio.post(
        'mga/sps/oauth/oauth20/token',
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      if (enableLog) _networkLog(postMethod);
      return postMethod;
    } on DioException catch (e) {
      _traceError(e);
      rethrow;
    }
  }

  @override
  Future<Response> getUserData() async {
    try {
      var headers = {
        "content-type": "application/json",
        'Authorization': 'Bearer ' + sharedPrefsClient.accessToken
      };

      final postMethod = await _dio.get(
        ApiURLs.getStudentProfilePath,
        options: Options(
          headers: headers,
        ),
      );
      if (enableLog) _networkLog(postMethod);
      return postMethod;
    } on DioException catch (e) {
      _traceError(e);
      rethrow;
    }
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
        '╟ statusCode: ${e.response?.statusCode}\n'
        '╟ RESPONSE: ${e.response?.data} \n'
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
}
