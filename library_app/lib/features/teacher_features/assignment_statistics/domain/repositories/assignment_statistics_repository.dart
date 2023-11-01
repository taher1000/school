import 'package:dartz/dartz.dart';

import '../../../../../core/network/failure.dart';
import '../../data/models/assignment_statistics_summary_response.dart';

abstract class IAssignmentsStatisticsRepository {
  Future<Either<Failure, AssignmentsStatisticsSummaryResponsePage>>
      getAssignmentsStatistics(int pageNumber,
          {required int pageSize, String? studentID, String? bookID});
}
