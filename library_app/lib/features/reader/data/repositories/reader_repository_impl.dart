import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/models/book/book.dart';
import '../../../../../core/models/book/response/book_summary_response.dart';
import '../../../../../core/network/failure.dart';
import '../../../student_features/my_books/data/datasources/my_book_remote_datasource.dart';
import '../../domain/entities/request/book_completed_status.dart';
import '../../domain/repositories/reader_repository.dart';
import '../datasources/reader_remote_datasource.dart';

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
}
