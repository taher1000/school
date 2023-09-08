import 'package:dartz/dartz.dart';
import 'package:library_app/features/main/domain/entities/user.dart';

import '../entities/user_data.dart';

abstract class IUserRepository {
  Future<Either<String, User>> getUserData();
}
