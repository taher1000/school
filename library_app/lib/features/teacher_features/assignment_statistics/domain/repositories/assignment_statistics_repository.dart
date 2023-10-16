import 'package:dartz/dartz.dart';
import 'package:library_app/core/models/assignment/teacher_assignment_summary_response.dart';

import '../../../../../core/network/failure.dart';
import '../../data/models/assignment_statistics_summary_response.dart';

abstract class IAssignmentsStatisticsRepository {
  Future<Either<Failure, AssignmentsStatisticsSummaryResponsePage>>
      getAssignmentsStatistics(int pageNumber,
          {required int pageSize, String? studentID, String? bookID});
}
