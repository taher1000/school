import 'package:dartz/dartz.dart';
import 'package:library_app/features/main/domain/entities/user_data.dart';
import '../../../student_features/my_student_profile/domain/entities/student_data.dart';
import '../../../teacher_features/my_teacher_profile/domain/entities/teacher_data.dart';

abstract class IProfileRepository {
  Future<Either<String, UserData>> getTeacherProfileData();
  Future<Either<String, UserData>> getStudentProfileData();
  Future<Either<String, bool>> getAllData();
  Future<Either<String, String>> updateDeviceToken();
  Future<Either<String, bool>> checkUserTermsAgreement();
  Future<Either<String, bool>> setUserTermsAgreement(bool agree);
  Future<Either<String, bool>> notificationRegisterUser(
      {required String deviceID, required String deviceType});
}
