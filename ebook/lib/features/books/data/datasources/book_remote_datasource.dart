import 'package:dio/dio.dart';
import 'package:ebook/core/utils/utils.dart';
import '../../../../core/network/api_response_model.dart';
import '../../../../core/network/api_url.dart';
import '../../../../core/network/school_rest.dart';
import '../../../../injection_container.dart';

abstract class IBookRemoteDataSource {
  Future<ApiResponse> getBooks(int pageNumber,
      {required int pageSize, int? bookLevel});
}

class BookRemoteDataSource implements IBookRemoteDataSource {
  final ISchoolRest rest;

  BookRemoteDataSource(this.rest);

  @override
  Future<ApiResponse> getBooks(int pageNumber,
      {required int pageSize, int? bookLevel}) async {
    final response = await rest.get(
      '${ApiURLs.getAllBooksPath}?BookLevel=${AppUtils().bookLevelCheck(bookLevel)}&PageNumber=$pageNumber&PageSize=$pageSize',
      userToken: sharedPrefsClient.accessToken,
    );
    return response;
  }
}
