import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../domain/entities/auth.dart';
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
      if (response.statusCode! == 200) {
        authResponse = AuthResponse.fromJson(response.data);
        var auth = Auth(
          accessToken: authResponse.accessToken!,
        );
        return Right(authResponse);
      }
      return Left(authResponse!.errors![0]);
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response!.data["error_description"]);
      }

      return const Left('dio error');
    }
  }
}
