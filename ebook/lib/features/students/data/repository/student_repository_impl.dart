import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../models/response/all_student_summary_response.dart';

import '../../../../core/network/failure.dart';
import '../../domain/repository/student_repository.dart';
import '../datasource/student_datasource.dart';
import '../models/student.dart';

class GetAllStudentRepositoryImpl extends IGetAllStudentRepository {
  final IGetAllStudentRemoteDataSource remoteDataSource;

  GetAllStudentRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, AllStudentsSummaryResponsePage>> getStudents(
    int pageNumber, {
    int pageSize = 10,
    required int sectionID,
    required int classYearID,
  }) async {
    try {
      var response = await remoteDataSource.getStudents(pageNumber,
          pageSize: pageSize, sectionID: sectionID, classYearID: classYearID);
      if (response.errors!.isEmpty && response.succeeded!) {
        return Right(AllStudentsSummaryResponsePage(
          pageNumber: response.pageNumber,
          data: List<StudentModel>.from(
              response.data!.map((x) => StudentModel.fromJson(x))),
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
