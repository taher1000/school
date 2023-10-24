import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:library_app/features/reader/data/parameters/book_content_params.dart';

import '../../../../../core/network/failure.dart';
import '../../domain/entities/request/book_completed_status.dart';
import '../../domain/repositories/reader_repository.dart';
import '../datasources/reader_remote_datasource.dart';
import '../models/book_content_summary_response.dart';

class ReaderRepositoryImpl extends IReaderRepository {
  final IReaderRemoteDataSource remoteDataSource;

  ReaderRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, String>> saveStudentBookStatus(
      BookCompletedStatus bookCompletedStatus) async {
    try {
      var response =
          await remoteDataSource.saveStudentBookStatus(bookCompletedStatus);
      if (response.errors!.isEmpty && response.succeeded!) {
        return Right(response.message!);
      } else {
        return Left(Failure(message: response.errors![0]));
      }
    } on DioException catch (_) {
      return const Left(Failure(message: "error_message"));
    }
  }

  @override
  Future<Either<Failure, BookContentSummaryResponsePage>> getBookContent(
      BookContentParams bookContentParams) async {
    try {
      var response = await remoteDataSource.getBookContent(bookContentParams);
      if (response.errors!.isEmpty && response.succeeded!) {
        return Right(BookContentSummaryResponsePage(
          pageNumber: response.pageNumber,
          data: List<String>.from(response.data!),
          nextPage: response.nextPage,
          message: response.message,
          errors: response.errors,
          succeeded: response.succeeded,
          pageSize: response.pageSize,
          totalPages: response.totalPages,
          totalRecords: response.totalRecords,
        ));
      } else {
        return Left(Failure(message: response.message!));
      }
    } on DioException catch (_) {
      return const Left(Failure(message: "error_message"));
    }
  }
}
