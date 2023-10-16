import 'package:dartz/dartz.dart';
import '../../../../../core/network/failure.dart';
import '../../../../../core/uscecase/usecase.dart';

import '../../data/models/assignment_statistics_summary_response.dart';
import '../params/assignment_statistics_params.dart';
import '../repositories/assignment_statistics_repository.dart';

class GetAssignmentsStatisticsUseCase extends UseCase<
    Either<Failure, AssignmentsStatisticsSummaryResponsePage>,
    AssignmentStatisticsParams> {
  final IAssignmentsStatisticsRepository repository;
  GetAssignmentsStatisticsUseCase(this.repository);
  @override
  Future<Either<Failure, AssignmentsStatisticsSummaryResponsePage>> call(
      {AssignmentStatisticsParams? p}) async {
    return await repository.getAssignmentsStatistics(p!.pageNumber,
        pageSize: p.pageSize, studentID: p.studentID, bookID: p.bookID);
  }
}
