import '../../../../../core/network/api_response_model.dart';
import '../../../../../core/network/api_url.dart';
import '../../../../../core/network/school_rest.dart';
import '../../../../../injection_container.dart';

abstract class IMyFavoriteBookRemoteDataSource {
  Future<ApiResponse> getMyFavoriteBooks(int pageNumber,
      {int pageSize = 10, int? bookLevel});
}

class MyFavoriteBookRemoteDataSourceImpl
    implements IMyFavoriteBookRemoteDataSource {
  final ISchoolRest rest;

  MyFavoriteBookRemoteDataSourceImpl(this.rest);

  @override
  Future<ApiResponse> getMyFavoriteBooks(int pageNumber,
      {int pageSize = 10, int? bookLevel}) async {
    final response = await rest.get(
      '${ApiURLs.myFavoriteBooksPath}?BookLevel=${bookLevel ?? ""}&PageNumber=$pageNumber&PageSize=$pageSize',
      userToken: sharedPrefsClient.accessToken,
    );
    return response;
  }
}
