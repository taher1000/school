import 'package:dio/dio.dart';
import 'package:ebook/core/network/api_response_model.dart';
import 'package:ebook/core/network/api_url.dart';
import 'package:ebook/core/network/school_rest.dart';
import 'package:ebook/features/books/data/models/book.dart';
import 'package:ebook/injection_container.dart';

abstract class IAssignmentRemoteDataSource {
  Future<ApiResponse> getAssignments(int pageNumber, {int pageSize = 10});
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
}
