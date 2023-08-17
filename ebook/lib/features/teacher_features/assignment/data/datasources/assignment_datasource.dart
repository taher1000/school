import 'package:dio/dio.dart';
import '../../../../../core/network/api_response_model.dart';
import '../../../../../core/network/api_url.dart';
import '../../../../../core/network/school_rest.dart';
import '../../../../books/data/models/book.dart';
import '../../../../../injection_container.dart';

abstract class IAssignmentRemoteDataSource {
  Future<ApiResponse> getAssignments(int pageNumber, {int pageSize = 10});
  Future<ApiResponse> addAssignment(int pageNumber, {int pageSize = 10});
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
  Future<ApiResponse> addAssignment(int pageNumber, {int pageSize = 10}) {
    // TODO: implement addAssignment
    throw UnimplementedError();
  }
}
