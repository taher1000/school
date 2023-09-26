import '../../../../../core/utils/utils.dart';
import '../../../../reader/domain/entities/request/book_completed_status.dart';

import '../../../../../core/network/api_response_model.dart';
import '../../../../../core/network/api_url.dart';
import '../../../../../core/network/school_rest.dart';
import '../../../../../injection_container.dart';
import '../../../../reader/data/models/book_completed_status.dart';

abstract class IMyBookRemoteDataSource {
  Future<ApiResponse> getBooks(int pageNumber,
      {required int pageSize, int? bookLevel});
}

class MyBookRemoteDataSourceImpl implements IMyBookRemoteDataSource {
  final ISchoolRest rest;

  MyBookRemoteDataSourceImpl(this.rest);

  @override
  Future<ApiResponse> getBooks(int pageNumber,
      {required int pageSize, int? bookLevel}) async {
    final response = await rest.get(
      '${ApiURLs.getMyBooksPath}?BookLevel=${AppUtils().bookLevelCheck(bookLevel)}&PageNumber=$pageNumber&PageSize=$pageSize',
      userToken: sharedPrefsClient.accessToken,
    );
    return response;
  }
}
