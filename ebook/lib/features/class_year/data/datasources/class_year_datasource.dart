import '../../../../core/network/api_response_model.dart';
import '../../../../core/network/api_url.dart';
import '../../../../core/network/school_rest.dart';
import '../../../../injection_container.dart';

abstract class IClassYearRemoteDataSource {
  Future<ApiResponse> getClassYear();
}

class ClassYearRemoteDataSource implements IClassYearRemoteDataSource {
  final ISchoolRest rest;

  ClassYearRemoteDataSource(this.rest);

  @override
  Future<ApiResponse> getClassYear() async {
    final response = await rest.get(
      ApiURLs.getClassYearPath,
      userToken: sharedPrefsClient.accessToken,
    );
    return response;
  }
}
