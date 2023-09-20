import 'package:library_app/features/reader/domain/entities/request/book_completed_status.dart';

import '../../../../../core/network/api_response_model.dart';
import '../../../../../core/network/api_url.dart';
import '../../../../../core/network/school_rest.dart';
import '../../../../../injection_container.dart';
import '../models/book_completed_status.dart';

abstract class IReaderRemoteDataSource {
  Future<ApiResponse> saveStudentBookStatus(
      BookCompletedStatus bookCompletedStatus);
}

class ReaderRemoteDataSourceImpl implements IReaderRemoteDataSource {
  final ISchoolRest rest;

  ReaderRemoteDataSourceImpl(this.rest);

  @override
  Future<ApiResponse> saveStudentBookStatus(
      BookCompletedStatus bookCompletedStatus) async {
    final response = await rest.post(
      ApiURLs.saveStudentBookStatusPath,
      userToken: sharedPrefsClient.accessToken,
      data: bookCompletedStatusModelToJson(bookCompletedStatus.toModel()),
    );
    return response;
  }
}
