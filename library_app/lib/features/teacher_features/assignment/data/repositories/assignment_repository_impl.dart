import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../models/response/follow_up_assignment_summary_response.dart';
import '../models/response/follow_up_student.dart';
import '../../domain/entities/request/assignment_post_request.dart';
import '../../domain/entities/response/assignment_details.dart';

import '../../../../../core/models/assignment/teacher_assignment_model.dart';
import '../../../../../core/models/assignment/teacher_assignment_summary_response.dart';
import '../datasources/assignment_datasource.dart';
import '../../domain/repositories/assignment_repository.dart';

import '../../../../../core/network/failure.dart';
import '../models/response/assignment_details.dart';

class AssignmentRepositoryImpl extends IAssignmentRepository {
  final IAssignmentRemoteDataSource remoteDataSource;
  AssignmentRepositoryImpl({
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, TeacherAssignmentSummaryResponsePage>> getAssignments(
      int pageNumber,
      {int pageSize = 10}) async {
    try {
      var response =
          await remoteDataSource.getAssignments(pageNumber, pageSize: pageSize);
      if (response.errors!.isEmpty && response.succeeded!) {
        return Right(TeacherAssignmentSummaryResponsePage(
          pageNumber: response.pageNumber,
          data: List<TeacherAssignmentModel>.from(
              response.data!.map((x) => TeacherAssignmentModel.fromJson(x))),
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

  @override
  Future<Either<Failure, String>> deleteAssignment(String id) async {
    try {
      var response = await remoteDataSource.deleteAssignment(id);
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
  Future<Either<Failure, FollowUpAssignmentSummaryResponsePage>>
      getAllFollowUpStudentAssignments(int pageNumber,
          {required int pageSize}) async {
    try {
      var response = await remoteDataSource
          .getAllFollowUpStudentAssignments(pageNumber, pageSize: pageSize);
      if (response.errors!.isEmpty && response.succeeded!) {
        return Right(FollowUpAssignmentSummaryResponsePage(
          pageNumber: response.pageNumber,
          data: List<FollowUpStudentModel>.from(
              response.data!.map((x) => FollowUpStudentModel.fromJson(x))),
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
