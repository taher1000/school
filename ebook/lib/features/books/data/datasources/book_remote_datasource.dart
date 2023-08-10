import 'package:dio/dio.dart';
import 'package:ebook/core/network/api_response_model.dart';
import 'package:ebook/core/network/api_url.dart';
import 'package:ebook/core/network/school_rest.dart';
import 'package:ebook/features/books/data/models/book.dart';
import 'package:ebook/injection_container.dart';

import '../../domain/entities/book.dart';

abstract class IBookRemoteDataSource {
  Future<ApiResponse> getBooks(int pageNumber, {int pageSize = 10});
}

class BookRemoteDataSource implements IBookRemoteDataSource {
  final ISchoolRest rest;

  BookRemoteDataSource(this.rest);

  @override
  Future<ApiResponse> getBooks(int pageNumber, {int pageSize = 10}) async {
    final response = await rest.get(
      '${ApiURLs.getBooksPath}?PageNumber=$pageNumber&PageSize=$pageSize',
      userToken: sharedPrefsClient.accessToken,
    );
    return response;
  }
}
