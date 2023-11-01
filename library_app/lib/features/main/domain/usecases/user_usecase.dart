import 'package:dartz/dartz.dart';
import '../../../student_features/my_student_profile/domain/entities/student_data.dart';
import '../../../teacher_features/my_teacher_profile/domain/entities/teacher_data.dart';

import '../../../../core/uscecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/user_profile_repository.dart';
import '../repositories/user_repository.dart';

class ProfileDataUseCase extends UseCase<Either<String, User>, void> {
  final IProfileRepository _profileRepository;
  final IUserRepository _userRepository;

  ProfileDataUseCase(this._profileRepository, this._userRepository);

  @override
  Future<Either<String, User>> call({void p}) async {
    return await _userRepository.getUserData();
  }

  Future<Either<String, String?>> getUserImage() async {
    var user = await _userRepository.getUserData();

    return user.fold((l) => Left(l), (r) => const Right(""));
  }

  Future<Either<String, String>> updateDeviceToken() async {
    return await _profileRepository.updateDeviceToken();
  }

  Future<Either<String, bool>> getAllData() async {
    return await _profileRepository.getAllData();
  }

  Future<Either<String, bool>> checkUserTermsAgreement() async {
    return await _profileRepository.checkUserTermsAgreement();
  }

  Future<Either<String, bool>> setUserTermsAgreement(bool agree) async {
    return await _profileRepository.setUserTermsAgreement(agree);
  }

  Future<Either<String, bool>> notificationRegisterUser(
      {required String deviceID, required String deviceType}) async {
    return await _profileRepository.notificationRegisterUser(
        deviceID: deviceID, deviceType: deviceType);
  }

  Future<Either<String, TeacherData>> getTeacherProfileData({void p}) async {
    return await _profileRepository.getTeacherProfileData();
  }

  Future<Either<String, StudentData>> getStudentProfileData({void p}) async {
    return await _profileRepository.getStudentProfileData();
  }
}
