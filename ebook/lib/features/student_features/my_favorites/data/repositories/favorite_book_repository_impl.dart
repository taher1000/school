import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ebook/core/models/assignment/student_assignment.dart';
import 'package:ebook/core/models/assignment/student_assignment_summary_response.dart';
import 'package:ebook/features/student_features/my_assignments/data/datasources/my_assignment_data_source.dart';
import 'package:ebook/features/student_features/my_favorites/data/datasources/my_favorite_books_data_source.dart';
import 'package:ebook/features/student_features/my_favorites/data/models/favorite_book.dart';
import 'package:ebook/features/student_features/my_favorites/data/models/favorite_book_summary_response.dart';
import 'package:ebook/features/student_features/my_favorites/domain/repositories/favorite_book_repository.dart';

import '../../../../../core/network/failure.dart';

class MyFavoriteBooksRepositoryImpl extends IMyFavoriteBooksRepository {
  final IMyFavoriteBookRemoteDataSource remoteDataSource;
  MyFavoriteBooksRepositoryImpl({
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, FavoriteBookSummaryResponsePage>> getMyFavoriteBooks(
      int pageNumber,
      {required int pageSize}) async {
    try {
      var response = await remoteDataSource.getMyFavoriteBooks(pageNumber,
          pageSize: pageSize);
      if (response.errors!.isEmpty && response.succeeded!) {
        return Right(FavoriteBookSummaryResponsePage(
          pageNumber: response.pageNumber,
          data: List<FavoriteBookModel>.from(
              response.data!.map((x) => FavoriteBookModel.fromJson(x))),
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

  @override
  Future<Either<Failure, String>> addMyFavoriteBook(String bookId) async {
    try {
      var response = await remoteDataSource.addFavorite(bookId);
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
  Future<Either<Failure, bool>> isFavoriteBook(String bookId) async {
    try {
      var response = await remoteDataSource.isFavoriteBook(bookId);
      if (response.errors!.isEmpty && response.succeeded!) {
        return Right(response.data);
      } else {
        return Left(Failure(message: response.errors![0]));
      }
    } on DioException catch (_) {
      return const Left(Failure(message: "error_message"));
    }
  }
}
