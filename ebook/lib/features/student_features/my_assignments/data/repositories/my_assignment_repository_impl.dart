import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ebook/core/models/assignment/student_assignment.dart';
import 'package:ebook/core/models/assignment/student_assignment_summary_response.dart';
import 'package:ebook/features/student_features/my_assignments/data/datasources/my_assignment_data_source.dart';

import '../../domain/repositories/my_assignment_repository.dart';

import '../../../../../core/network/failure.dart';

class MyAssignmentRepositoryImpl extends IMyAssignmentRepository {
  final IMyAssignmentRemoteDataSource remoteDataSource;
  MyAssignmentRepositoryImpl({
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, StudentAssignmentSummaryResponsePage>>
      getMyAssignments(int pageNumber, {int pageSize = 10}) async {
    try {
      var response = await remoteDataSource.getMyAssignments(pageNumber,
          pageSize: pageSize);
      if (response.errors!.isEmpty && response.succeeded!) {
        return Right(StudentAssignmentSummaryResponsePage(
          pageNumber: response.pageNumber,
          data: List<StudentAssignmentModel>.from(
              response.data!.map((x) => StudentAssignmentModel.fromJson(x))),
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
