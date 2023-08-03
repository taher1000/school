import 'package:dartz/dartz.dart';
import '../entities/user.dart';

abstract class IProfileRepository {
  Future<Either<String, User>> getUserData();
  Future<Either<String, bool>> getAllData();
  Future<Either<String, String>> updateDeviceToken();
  Future<Either<String, bool>> checkUserTermsAgreement();
  Future<Either<String, bool>> setUserTermsAgreement(bool agree);
  Future<Either<String, bool>> notificationRegisterUser(
      {required String deviceID, required String deviceType});
}
