import 'package:dartz/dartz.dart';
import '../../../../../core/network/failure.dart';
import '../../../../../core/params/pagination_params.dart';
import '../../../../../core/uscecase/usecase.dart';
import '../../data/models/response/follow_up_assignment_summary_response.dart';
import '../repositories/assignment_repository.dart';

class GetAllFollowUpAssignmentsUseCase extends UseCase<
    Either<Failure, FollowUpAssignmentSummaryResponsePage>,
    PaginationParameters> {
  final IAssignmentRepository repository;
  GetAllFollowUpAssignmentsUseCase(this.repository);
  @override
  Future<Either<Failure, FollowUpAssignmentSummaryResponsePage>> call(
      {PaginationParameters? p}) async {
    return await repository.getAllFollowUpStudentAssignments(p!.pageNumber,
        pageSize: p.pageSize);
  }
}
