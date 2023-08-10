import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ebook/features/teacher/assignment/data/datasources/assignment_datasource.dart';
import 'package:ebook/features/teacher/assignment/data/models/assignment_model.dart';
import 'package:ebook/features/teacher/assignment/domain/entities/assignment.dart';
import 'package:ebook/features/teacher/assignment/domain/repositories/assignment_repository.dart';

import '../../../../../core/network/failure.dart';

class AssignmentRepositoryImpl extends IAssignmentRepository {
  final IAssignmentRemoteDataSource remoteDataSource;
  AssignmentRepositoryImpl({
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, List<Assignment>>> getAssignments(int pageNumber,
      {int pageSize = 10}) async {
    try {
      var response =
          await remoteDataSource.getAssignments(pageNumber, pageSize: pageSize);
      if (response.errors!.isEmpty && response.succeeded!) {
        List<Assignment> bookData = [];
        // final data = BookSummaryResponsePage.fromJson(response.data![0]);
        for (var i = 0; i < response.data!.length; i++) {
          final book = AssignmentModel.fromJson(response.data![i]);
          bookData.add(book);
        }
        return Right(bookData);
      } else {
        return Left(Failure(message: response.message!));
      }
    } on DioException catch (_) {
      return const Left(Failure(message: "error_message"));
    }
  }
}
