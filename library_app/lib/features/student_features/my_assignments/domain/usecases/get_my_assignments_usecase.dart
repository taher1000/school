import 'package:dartz/dartz.dart';
import '../../../../../core/models/assignment/student_assignment_summary_response.dart';
import '../repositories/my_assignment_repository.dart';
import '../../../my_books/domain/parameters/book_params.dart';
import '../../../../../core/network/failure.dart';
import '../../../../../core/uscecase/usecase.dart';

class GetStudentMyAssignmentsUseCase extends UseCase<
    Either<Failure, StudentAssignmentSummaryResponsePage>, MyBookParams> {
  final IMyAssignmentRepository repository;
  GetStudentMyAssignmentsUseCase(this.repository);
  @override
  Future<Either<Failure, StudentAssignmentSummaryResponsePage>> call(
      {MyBookParams? p}) async {
    final res =
        await repository.getMyAssignments(p!.pageNumber, pageSize: p.pageSize);
    return res;
  }
}
