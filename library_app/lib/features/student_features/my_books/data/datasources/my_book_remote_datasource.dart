import '../../../../../core/utils/utils.dart';

import '../../../../../core/network/api_response_model.dart';
import '../../../../../core/network/api_url.dart';
import '../../../../../core/network/school_rest.dart';
import '../../../../../injection_container.dart';

abstract class IMyBookRemoteDataSource {
  Future<ApiResponse> getBooks(int pageNumber,
      {required int pageSize, int? bookLevel, String? search});
}

class MyBookRemoteDataSourceImpl implements IMyBookRemoteDataSource {
  final ISchoolRest rest;

  MyBookRemoteDataSourceImpl(this.rest);

  @override
  Future<ApiResponse> getBooks(int pageNumber,
      {required int pageSize, int? bookLevel, String? search}) async {
    final searchValue = AppUtils().searchTextNullCheck(search);

    final response = await rest.get(
      '${ApiURLs.getMyBooksPath}?BookLevel=${AppUtils().bookLevelCheck(bookLevel)}&PageNumber=$pageNumber&PageSize=$pageSize&WildCardSearch=$searchValue',
      userToken: sharedPrefsClient.accessToken,
    );
    return response;
  }
}
