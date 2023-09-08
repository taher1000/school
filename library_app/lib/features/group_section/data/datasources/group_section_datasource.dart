import '../../../../core/network/api_response_model.dart';
import '../../../../core/network/api_url.dart';
import '../../../../core/network/school_rest.dart';
import '../../../../injection_container.dart';

abstract class ISectionGroupRemoteDataSource {
  Future<ApiResponse> getSectionGroup(int classYear);
}

class SectionGroupRemoteDataSource implements ISectionGroupRemoteDataSource {
  final ISchoolRest rest;

  SectionGroupRemoteDataSource(this.rest);

  @override
  Future<ApiResponse> getSectionGroup(int classYear) async {
    final response = await rest.get(
      "${ApiURLs.getSectionGroupPath}?ClassYearID=$classYear",
      userToken: sharedPrefsClient.accessToken,
    );
    return response;
  }
}
