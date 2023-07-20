import 'package:dartz/dartz.dart';

import '../../../../core/uscecase/usecase.dart';
import '../../data/models/auth_response.dart';
import '../entities/auth.dart';
import '../params/auth_parameters.dart';
import '../repositories/auth_repository.dart';

class AuthenticateUseCase
    extends UseCase<Either<String, AuthResponse>, AuthParameters> {
  final IAuthRepository _authRepository;

  AuthenticateUseCase(this._authRepository);

  @override
  Future<Either<String, AuthResponse>> call({AuthParameters? p}) async {
    return await _authRepository.authenticate(p!);
  }
}
