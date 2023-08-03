import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_profile_repository.dart';
import '../datasource/user_profile_datasource.dart';
import '../model/user_response.dart';
import '../model/user_terms_agreement_response.dart';

class ProfileRepository implements IProfileRepository {
  final IProfileRemoteDataSource _userRemoteDataSource;

  ProfileRepository(
    this._userRemoteDataSource,
  );

  @override
  Future<Either<String, User>> getUserData() async {
    try {
      var response = await _userRemoteDataSource.getUserData();
      if (response.statusCode == 200 && response is! String) {
        var userResponse = UserResponse.fromJson(response.data);
        var user = User(
          arabicFullName: userResponse.arabicFullName ?? "",
          englishFullName: userResponse.englishFullName ?? "",
          email: userResponse.email ?? "",
          image: "",
          phoneNumber: userResponse.phoneNumber ?? "",
          userName: userResponse.userName ?? "",
          userRole: userResponse.userRole ?? 0,
          token: userResponse.token ?? "",
          refreshToken: userResponse.refreshToken ?? "",
          birthDate: userResponse.birthDate,
        );

        return Right(user);
      }
      return const Left('error_message');
    } on DioError catch (_) {
      return const Left("error_message");
    }
  }

  @override
  Future<Either<String, bool>> getAllData() async {
    try {
      var response = await _userRemoteDataSource.getAllData();

      if (response.succeeded == 200) {
        return const Right(true);
      } else {
        return Left(response.message ?? "error_message");
      }
    } on DioError catch (_) {
      return const Left("error_message");
    }
  }

  @override
  Future<Either<String, String>> updateDeviceToken() async {
    try {
      var response = await _userRemoteDataSource.updateDeviceToken();
      if (response.succeeded == true) {
        return const Right('');
      } else {
        return Left(response.message ?? "error_message");
      }
    } on DioError catch (_) {
      return const Left("error_message");
    }
  }

  @override
  Future<Either<String, bool>> checkUserTermsAgreement() async {
    try {
      var response = await _userRemoteDataSource.checkUserTermsAgreement();

      if (response.succeeded == true) {
        var reponseData = UserTermsAgreementResponse.fromJson(response.data[0]);

        return Right(reponseData.agreed ?? false);
      } else {
        return const Right(false);
      }
    } on DioError catch (_) {
      return const Left("error_message");
    }
  }

  @override
  Future<Either<String, bool>> setUserTermsAgreement(bool agree) async {
    try {
      var response = await _userRemoteDataSource.setUserTermsAgreement(agree);

      if (response.succeeded == 200) {
        return const Right(true);
      } else {
        return const Right(false);
      }
    } on DioError catch (_) {
      return const Left("error_message");
    }
  }

  @override
  Future<Either<String, bool>> notificationRegisterUser(
      {required String deviceID, required String deviceType}) async {
    try {
      var response = await _userRemoteDataSource.notificationRegisterUser(
          deviceID: deviceID, deviceType: deviceType);

      if (response.succeeded == 200) {
        return const Right(true);
      } else {
        return const Right(false);
      }
    } on DioError catch (_) {
      return const Left("error_message");
    }
  }
}
