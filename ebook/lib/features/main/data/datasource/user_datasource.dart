import 'package:ebook/core/network/school_rest.dart';

import '../../../../core/network/api_response_model.dart';

abstract class IUserRemoteDataSource {
  Future<ApiResponse> getUserData(String nationalId);
}

class UserRemoteDataSource implements IUserRemoteDataSource {
  final ISchoolRest _sanadRest;
  UserRemoteDataSource(this._sanadRest);
  @override
  Future<ApiResponse> getUserData(String nationalId) async {
    return await _sanadRest
        .get("User/GetUserById", queryParameters: {"NationalID": nationalId});
  }
}
