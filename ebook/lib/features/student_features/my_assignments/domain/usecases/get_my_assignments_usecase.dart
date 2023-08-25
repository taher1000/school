import 'package:dartz/dartz.dart';
import 'package:ebook/core/models/assignment/student_assignment_summary_response.dart';
import 'package:ebook/features/student_features/my_assignments/domain/repositories/my_assignment_repository.dart';
import '../../../../../core/network/failure.dart';
import '../../../../../core/params/pagination_params.dart';
import '../../../../../core/uscecase/usecase.dart';

class GetStudentMyAssignmentsUseCase extends UseCase<
    Either<Failure, StudentAssignmentSummaryResponsePage>,
    PaginationParameters> {
  final IMyAssignmentRepository repository;
  GetStudentMyAssignmentsUseCase(this.repository);
  @override
  Future<Either<Failure, StudentAssignmentSummaryResponsePage>> call(
      {PaginationParameters? p}) async {
    return await repository.getMyAssignments(p!.pageNumber,
        pageSize: p.pageSize);
  }
}
