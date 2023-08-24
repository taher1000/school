import '../../../../../core/network/api_response_model.dart';
import '../../../../../core/network/api_url.dart';
import '../../../../../core/network/school_rest.dart';
import '../../../../../injection_container.dart';

abstract class IMyBookRemoteDataSource {
  Future<ApiResponse> getBooks(int pageNumber,
      {int pageSize = 10, int? bookLevel});
}

class MyBookRemoteDataSourceImpl implements IMyBookRemoteDataSource {
  final ISchoolRest rest;

  MyBookRemoteDataSourceImpl(this.rest);

  @override
  Future<ApiResponse> getBooks(int pageNumber,
      {int pageSize = 10, int? bookLevel}) async {
    final response = await rest.get(
      '${ApiURLs.getMyBooksPath}?BookLevel=${bookLevel ?? ""}&PageNumber=$pageNumber&PageSize=$pageSize',
      userToken: sharedPrefsClient.accessToken,
    );
    return response;
  }
}
