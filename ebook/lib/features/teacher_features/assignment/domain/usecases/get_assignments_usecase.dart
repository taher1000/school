import 'package:dartz/dartz.dart';
import '../../../../../core/models/assignment/teacher_assignment_summary_response.dart';
import '../../../../../core/network/failure.dart';
import '../../../../../core/params/pagination_params.dart';
import '../../../../../core/uscecase/usecase.dart';
import '../repositories/assignment_repository.dart';

class GetAssignmentsUseCase extends UseCase<
    Either<Failure, TeacherAssignmentSummaryResponsePage>,
    PaginationParameters> {
  final IAssignmentRepository repository;
  GetAssignmentsUseCase(this.repository);
  @override
  Future<Either<Failure, TeacherAssignmentSummaryResponsePage>> call(
      {PaginationParameters? p}) async {
    return await repository.getAssignments(p!.pageNumber, pageSize: p.pageSize);
  }
}
