import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../datasources/assignment_datasource.dart';
import '../models/assignment_model.dart';
import '../models/assignment_summary_response.dart';
import '../../domain/entities/assignment.dart';
import '../../domain/entities/request/book_collection_body.dart';
import '../../domain/repositories/assignment_repository.dart';

import '../../../../../core/network/failure.dart';

class AssignmentRepositoryImpl extends IAssignmentRepository {
  final IAssignmentRemoteDataSource remoteDataSource;
  AssignmentRepositoryImpl({
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, AssignmentSummaryResponsePage>> getAssignments(
      int pageNumber,
      {int pageSize = 10}) async {
    try {
      var response =
          await remoteDataSource.getAssignments(pageNumber, pageSize: pageSize);
      if (response.errors!.isEmpty && response.succeeded!) {
        return Right(AssignmentSummaryResponsePage(
          pageNumber: response.pageNumber,
          data: List<AssignmentModel>.from(
              response.data!.map((x) => AssignmentModel.fromJson(x))),
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
  Future<Either<Failure, AssignmentSummaryResponsePage>> addAssignment(
      BookCollection bookCollection) {
    // TODO: implement addAssignment
    throw UnimplementedError();
  }
}
