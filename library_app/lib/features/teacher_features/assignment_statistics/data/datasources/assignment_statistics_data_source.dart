import '../../../../../core/network/api_response_model.dart';
import '../../../../../core/network/api_url.dart';
import '../../../../../core/network/school_rest.dart';
import '../../../../../injection_container.dart';

abstract class IAssignmentsStatisticsRemoteDataSource {
  Future<ApiResponse> getAssignmentsStatistics(int pageNumber,
      {int pageSize = 100, String? studentID, String? bookID});
}

class AssignmentsStatisticsRemoteDataSourceImpl
    implements IAssignmentsStatisticsRemoteDataSource {
  final ISchoolRest rest;

  AssignmentsStatisticsRemoteDataSourceImpl(this.rest);

  @override
  Future<ApiResponse> getAssignmentsStatistics(int pageNumber,
      {int pageSize = 100, String? studentID = "", String? bookID = ""}) async {
    final response = await rest.get(
      '${ApiURLs.getAssignmentStatisticsPath}?PageNumber=$pageNumber&PageSize=$pageSize&StudentID=$studentID&BookID=$bookID',
      userToken: sharedPrefsClient.accessToken,
    );
    return response;
  }
}
