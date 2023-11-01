
import '../../../../../core/network/api_response_model.dart';
import '../../../../../core/network/api_url.dart';
import '../../../../../core/network/school_rest.dart';
import '../../../../../injection_container.dart';

abstract class IMyFavoriteBookRemoteDataSource {
  Future<ApiResponse> getMyFavoriteBooks(int pageNumber,
      {required int pageSize});

  Future<ApiResponse> addFavorite(String bookId);
  Future<ApiResponse> isFavoriteBook(String bookId);
}

class MyFavoriteBookRemoteDataSourceImpl
    implements IMyFavoriteBookRemoteDataSource {
  final ISchoolRest rest;

  MyFavoriteBookRemoteDataSourceImpl(this.rest);

  @override
  Future<ApiResponse> getMyFavoriteBooks(int pageNumber,
      {required int pageSize}) async {
    final response = await rest.get(
      '${ApiURLs.myFavoriteBooksPath}?PageNumber=$pageNumber&PageSize=$pageSize',
      userToken: sharedPrefsClient.accessToken,
    );
    return response;
  }

  @override
  Future<ApiResponse> addFavorite(String bookId) {
    return rest.post(ApiURLs.favoriteBookPath,
        userToken: sharedPrefsClient.accessToken,
        data: {
          'bookID': bookId,
        });
  }

  @override
  Future<ApiResponse> isFavoriteBook(String bookId) {
    return rest.get(
      "${ApiURLs.getIsFavoriteBookPath}?bookID=$bookId",
      userToken: sharedPrefsClient.accessToken,
    );
  }
}
