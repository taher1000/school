import 'package:dartz/dartz.dart';
import 'package:library_app/features/main/domain/entities/user.dart';

import '../../domain/entities/user_data.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasource/user_datasource.dart';
import '../model/user_data_response.dart';
import '../model/user_response.dart';

class UserRepository implements IUserRepository {
  final IUserRemoteDataSource _dataSource;
  UserRepository(this._dataSource);
  @override
  Future<Either<String, User>> getUserData() async {
    try {
      var response = await _dataSource.getUserData();
      if (response.succeeded == true) {
        var userResponse = UserResponse.fromJson(response.data![0]);
        var user = User(
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
