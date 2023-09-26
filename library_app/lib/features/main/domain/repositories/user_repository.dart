import 'package:dartz/dartz.dart';
import '../entities/user.dart';

import '../entities/user_data.dart';

abstract class IUserRepository {
  Future<Either<String, User>> getUserData();
}
