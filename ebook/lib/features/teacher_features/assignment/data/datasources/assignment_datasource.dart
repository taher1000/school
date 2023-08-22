import 'package:dio/dio.dart';
import '../../../../../core/network/api_response_model.dart';
import '../../../../../core/network/api_url.dart';
import '../../../../../core/network/school_rest.dart';
import '../../../../books/data/models/book.dart';
import '../../../../../injection_container.dart';
import '../models/request/assignment_post_request.dart';

abstract class IAssignmentRemoteDataSource {
  Future<ApiResponse> getAssignments(int pageNumber, {int pageSize = 10});
  Future<ApiResponse> addAssignment(AssignmentPostRequestBodyModel body);
  Future<ApiResponse> getAssignmentByID(String id);
}

class AssignmentRemoteDataSource implements IAssignmentRemoteDataSource {
  final ISchoolRest rest;

  AssignmentRemoteDataSource(this.rest);

  @override
  Future<ApiResponse> getAssignments(int pageNumber,
      {int pageSize = 10}) async {
    final response = await rest.get(
      '${ApiURLs.getAssignmentsPath}?PageNumber=$pageNumber&PageSize=$pageSize',
      userToken: sharedPrefsClient.accessToken,
    );
    return response;
  }

  @override
  Future<ApiResponse> addAssignment(AssignmentPostRequestBodyModel body) async {
    final response = rest.post(
      ApiURLs.getAssignmentsPath,
      userToken: sharedPrefsClient.accessToken,
      data: body.toJson(),
    );
    return response;
  }

  @override
  Future<ApiResponse> getAssignmentByID(String id) async {
    final response = await rest.get(
      '${ApiURLs.getAssignmentsPath}/$id',
      userToken: sharedPrefsClient.accessToken,
    );
    return response;
  }
}
