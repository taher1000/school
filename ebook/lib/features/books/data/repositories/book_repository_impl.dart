import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ebook/features/books/data/datasources/book_remote_datasource.dart';
import 'package:ebook/features/books/data/models/book.dart';
import 'package:ebook/features/books/domain/entities/book.dart';
import 'package:ebook/features/books/domain/repositories/book_repository.dart';

import '../../../../core/network/failure.dart';
import '../models/response/book_summary_response.dart';

class BookRepositoryImpl extends IBookRepository {
  final IBookRemoteDataSource remoteDataSource;

  BookRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, BookSummaryResponsePage>> getBooks(int pageNumber,
      {int pageSize = 10}) async {
    try {
      var response =
          await remoteDataSource.getBooks(pageNumber, pageSize: pageSize);
      if (response.errors!.isEmpty && response.succeeded!) {
        return Right(BookSummaryResponsePage(
          pageNumber: response.pageNumber,
          data: List<BookModel>.from(
              response.data!.map((x) => BookModel.fromJson(x))),
          isLastPage: response.isLastPage,
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
