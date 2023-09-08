import '../../../../core/network/api_response_model.dart';
import '../../../../core/network/api_url.dart';
import '../../../../core/network/school_rest.dart';
import '../../../../injection_container.dart';

abstract class IGetAllStudentRemoteDataSource {
  Future<ApiResponse> getStudents(
    int pageNumber, {
    int pageSize = 10,
    int? sectionID,
    required int classYearID,
  });
}

class GetAllStudentRemoteDataSource implements IGetAllStudentRemoteDataSource {
  final ISchoolRest rest;

  GetAllStudentRemoteDataSource(this.rest);

  @override
  Future<ApiResponse> getStudents(int pageNumber,
      {int pageSize = 10, int? sectionID, required int classYearID}) async {
    final response = await rest.get(
      '${ApiURLs.getStudentsPath}?PageNumber=$pageNumber&PageSize=$pageSize&SectionID=${sectionID ?? ""}&ClassYearID=$classYearID',
      userToken: sharedPrefsClient.accessToken,
    );
    return response;
  }
}
