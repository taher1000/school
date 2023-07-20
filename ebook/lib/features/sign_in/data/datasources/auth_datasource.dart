import 'package:dio/dio.dart';
import 'package:ebook/core/network/idm_rest.dart';

import '../../domain/params/auth_parameters.dart';

abstract class IAuthRemoteDataSource {
  Future<Response> login(AuthParameters authParameters);
}

class AuthRemoteDataSource implements IAuthRemoteDataSource {
  final IIDMRest _idmRest;

  AuthRemoteDataSource(this._idmRest);
  @override
  Future<Response> login(AuthParameters authParameters) async {
    final response = await _idmRest.login(authParameters);
    return response;
  }
}
