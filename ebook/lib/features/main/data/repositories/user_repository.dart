import 'package:dartz/dartz.dart';

import '../../domain/entities/user_data.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasource/user_datasource.dart';
import '../model/user_data_response.dart';
import '../model/user_response.dart';

class UserRepository implements IUserRepository {
  final IUserRemoteDataSource _dataSource;
  UserRepository(this._dataSource);
  @override
  Future<Either<String, UserData>> getUserData(String nationalId) async {
    try {
      var response = await _dataSource.getUserData(nationalId);
      if (response.succeeded == true) {
        var userResponse = UserDataResponse.fromJson(response.data![0]);
        var user = UserData(
          arabicFullName: userResponse.arabicFullName,
          englishFullName: userResponse.englishFullName,
          email: userResponse.email,
          phoneNumber: userResponse.phoneNumber,
          refreshToken: userResponse.refreshToken,
          birthDate: userResponse.birthDate,
          token: userResponse.token,
          userName: userResponse.userName,
          userRole: userResponse.userRole,
        );

        return Right(user);
      } else {
        return Left(response.message!);
      }
    } catch (_) {
      return const Left('error_message');
    }
  }
}
