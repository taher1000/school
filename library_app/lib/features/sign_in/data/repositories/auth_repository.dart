import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/params/auth_parameters.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_datasource.dart';
import '../models/auth_response.dart';

class AuthRepository implements IAuthRepository {
  final IAuthRemoteDataSource _authRemoteDataSource;

  AuthRepository(
    this._authRemoteDataSource,
  );

  @override
  Future<Either<String, AuthResponse>> authenticate(
      AuthParameters authParameters) async {
    try {
      var response = await _authRemoteDataSource.login(authParameters);
      AuthResponse? authResponse;
      if (response.succeeded!) {
        authResponse = AuthResponse.fromJson(response.data);
        // var auth = Auth(
        //   accessToken: authResponse.token!,
        // );
        return Right(authResponse);
      }
      return Left("ERORR");
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response!.data["error_description"]);
      }

      return const Left('dio error');
    }
  }
}
