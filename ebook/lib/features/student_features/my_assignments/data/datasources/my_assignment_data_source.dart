import '../../../../../core/network/api_response_model.dart';
import '../../../../../core/network/api_url.dart';
import '../../../../../core/network/school_rest.dart';
import '../../../../../injection_container.dart';

abstract class IMyAssignmentRemoteDataSource {
  Future<ApiResponse> getMyAssignments(int pageNumber, {int pageSize = 10});
}

class MyAssignmentRemoteDataSourceImpl
    implements IMyAssignmentRemoteDataSource {
  final ISchoolRest rest;

  MyAssignmentRemoteDataSourceImpl(this.rest);

  @override
  Future<ApiResponse> getMyAssignments(int pageNumber,
      {int pageSize = 10}) async {
    final response = await rest.get(
      '${ApiURLs.getStudentAssignmentsPath}?PageNumber=$pageNumber&PageSize=$pageSize',
      userToken: sharedPrefsClient.accessToken,
    );
    return response;
  }
}
