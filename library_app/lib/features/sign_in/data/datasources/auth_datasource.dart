import 'package:dio/dio.dart';
import 'package:library_app/core/network/api_response_model.dart';
import '../../../../core/network/idm_rest.dart';

import '../../domain/params/auth_parameters.dart';

abstract class IAuthRemoteDataSource {
  Future<ApiResponse> login(AuthParameters authParameters);
}

class AuthRemoteDataSource implements IAuthRemoteDataSource {
  final IIDMRest _idmRest;

  AuthRemoteDataSource(this._idmRest);
  @override
  Future<ApiResponse> login(AuthParameters authParameters) async {
    final response = await _idmRest.login(authParameters);
    return response;
  }
}
