import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/network/failure.dart';
import '../../data/models/assignment_statistics_summary_response.dart';
import '../../domain/entities/assignment_statistics.dart';
import '../../domain/repositories/assignment_statistics_repository.dart';
import '../datasources/assignment_statistics_data_source.dart';
import '../models/assignment_statistics.dart';

class AssignmentsStatisticsRepositoryImpl
    extends IAssignmentsStatisticsRepository {
  final IAssignmentsStatisticsRemoteDataSource remoteDataSource;

  AssignmentsStatisticsRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, AssignmentsStatisticsSummaryResponsePage>>
      getAssignmentsStatistics(int pageNumber,
          {required int pageSize, String? studentID, String? bookID}) async {
    try {
      var response = await remoteDataSource.getAssignmentsStatistics(pageNumber,
          pageSize: pageSize);
      if (response.errors!.isEmpty && response.succeeded!) {
        return Right(AssignmentsStatisticsSummaryResponsePage(
          pageNumber: response.pageNumber,
          data: List<AssignmentStatistics>.from(
              response.data!.map((x) => AssignmentStatisticsModel.fromJson(x))),
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
