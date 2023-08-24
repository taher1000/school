import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ebook/features/teacher_features/assignment/domain/entities/request/assignment_post_request.dart';
import 'package:ebook/features/teacher_features/assignment/domain/entities/response/assignment_details.dart';

import '../datasources/assignment_datasource.dart';
import '../models/assignment_model.dart';
import '../models/assignment_summary_response.dart';
import '../../domain/repositories/assignment_repository.dart';

import '../../../../../core/network/failure.dart';
import '../models/response/assignment_details.dart';

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
  Future<Either<Failure, String>> addAssignment(
      AssignmentPostRequestBody postRequestBody) async {
    try {
      var response =
          await remoteDataSource.addAssignment(postRequestBody.toModel());
      if (response.errors!.isEmpty && response.succeeded!) {
        print("tito ${response.message}");
        return Right(response.message!);
      }
      return Left(Failure(message: response.errors![0]));
    } on DioException catch (e) {
      return Left(Failure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, AssignmentDetails>> getAssignmentByID(
      String id) async {
    try {
      var response = await remoteDataSource.getAssignmentByID(id);
      if (response.errors!.isEmpty && response.succeeded!) {
        final assignmentDetails =
            AssignmentDetailsModel.fromJson(response.data);
        return Right(assignmentDetails);
      } else {
        return Left(Failure(message: response.message!));
      }
    } on DioException catch (_) {
      return const Left(Failure(message: "error_message"));
    }
  }
}
