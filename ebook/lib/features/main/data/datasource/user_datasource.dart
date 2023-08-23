import 'package:ebook/core/network/api_url.dart';

import '../../../../core/network/school_rest.dart';

import '../../../../core/network/api_response_model.dart';
import '../../../../injection_container.dart';

abstract class IUserRemoteDataSource {
  Future<ApiResponse> getUserData();
}

class UserRemoteDataSource implements IUserRemoteDataSource {
  final ISchoolRest schoolRest;
  UserRemoteDataSource(this.schoolRest);
  @override
  Future<ApiResponse> getUserData() async {
    return await schoolRest.get(
      ApiURLs.getGetTeacherProfilePath,
      userToken: sharedPrefsClient.accessToken,
    );
  }
}
