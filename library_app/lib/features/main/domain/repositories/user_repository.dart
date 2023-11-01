import 'package:dartz/dartz.dart';
import '../entities/user.dart';


abstract class IUserRepository {
  Future<Either<String, User>> getUserData();
}
