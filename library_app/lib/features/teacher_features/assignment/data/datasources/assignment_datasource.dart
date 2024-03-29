import '../../../../../core/network/api_response_model.dart';
import '../../../../../core/network/api_url.dart';
import '../../../../../core/network/school_rest.dart';
import '../../../../../injection_container.dart';
import '../models/request/assignment_post_request.dart';

abstract class IAssignmentRemoteDataSource {
  Future<ApiResponse> getAssignments(int pageNumber, {int pageSize = 10});
  Future<ApiResponse> getAllFollowUpStudentAssignments(int pageNumber,
      {required int pageSize});
  Future<ApiResponse> addAssignment(AssignmentPostRequestBodyModel body);
  Future<ApiResponse> getAssignmentByID(String id);
  Future<ApiResponse> deleteAssignment(String id);
}

class AssignmentRemoteDataSource implements IAssignmentRemoteDataSource {
  final ISchoolRest rest;

  AssignmentRemoteDataSource(this.rest);

  @override
  Future<ApiResponse> getAssignments(int pageNumber,
      {int pageSize = 10}) async {
    final response = await rest.get(
      '${ApiURLs.getTeacherAssignmentsPath}?PageNumber=$pageNumber&PageSize=$pageSize',
      userToken: sharedPrefsClient.accessToken,
    );
    return response;
  }

  @override
  Future<ApiResponse> addAssignment(AssignmentPostRequestBodyModel body) async {
    final response = rest.post(
      ApiURLs.getTeacherAssignmentsPath,
      userToken: sharedPrefsClient.accessToken,
      data: body.toJson(),
    );
    return response;
  }

  @override
  Future<ApiResponse> getAssignmentByID(String id) async {
    final response = await rest.get(
      '${ApiURLs.getTeacherAssignmentsPath}/$id',
      userToken: sharedPrefsClient.accessToken,
    );
    return response;
  }

  @override
  Future<ApiResponse> deleteAssignment(String id) async {
    final response = await rest.delete(
      '${ApiURLs.getTeacherAssignmentsPath}/$id',
      userToken: sharedPrefsClient.accessToken,
    );
    return response;
  }

  @override
  Future<ApiResponse> getAllFollowUpStudentAssignments(int pageNumber,
      {required int pageSize}) async {
    final response = await rest.get(
      '${ApiURLs.getAllFollowUpAssignmentsPath}?PageNumber=$pageNumber&PageSize=$pageSize',
      userToken: sharedPrefsClient.accessToken,
    );
    return response;
  }
}
