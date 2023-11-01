import 'package:dartz/dartz.dart';
import '../../data/models/auth_response.dart';
import '../params/auth_parameters.dart';

abstract class IAuthRepository {
  Future<Either<String, AuthResponse>> authenticate(
      AuthParameters authParameters);
}
