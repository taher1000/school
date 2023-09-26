import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../model/user_data_response.dart';
import '../../domain/entities/user_data.dart';
import '../../../student_features/my_student_profile/data/models/student_data.dart';
import '../../../student_features/my_student_profile/domain/entities/student_data.dart';
import '../../../teacher_features/my_teacher_profile/data/models/teacher_data.dart';
import '../../../teacher_features/my_teacher_profile/domain/entities/teacher_data.dart';
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
  Future<Either<String, TeacherData>> getTeacherProfileData() async {
    try {
      var response = await _userRemoteDataSource.getTeacherData();
      if (response.succeeded == true) {
        var userResponse = TeacherDataModel.fromJson(response.data);

        return Right(userResponse);
      }
      return const Left('error_message');
    } on DioException catch (_) {
      return const Left("error_message");
    }
  }

  @override
  Future<Either<String, StudentData>> getStudentProfileData() async {
    try {
      var response = await _userRemoteDataSource.getStudentData();
      if (response.succeeded == true) {
        var userResponse = StudentDataModel.fromJson(response.data);

        return Right(userResponse);
      }
      return const Left('error_message');
    } on DioException catch (_) {
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
    } on DioException catch (_) {
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
    } on DioException catch (_) {
      return const Left("error_message");
    }
  }

  @override
  Future<Either<String, bool>> checkUserTermsAgreement() async {
    try {
      var response = await _userRemoteDataSource.checkUserTermsAgreement();

      if (response.succeeded == true) {
        var reponseData =
            UserTermsAgreementResponse.fromJson(response.data![0]);

        return Right(reponseData.agreed ?? false);
      } else {
        return const Right(false);
      }
    } on DioException catch (_) {
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
    } on DioException catch (_) {
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
    } on DioException catch (_) {
      return const Left("error_message");
    }
  }
}
