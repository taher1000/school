import 'package:dartz/dartz.dart';
import 'package:ebook/core/models/assignment/student_assignment_summary_response.dart';
import 'package:ebook/features/student_features/my_assignments/domain/repositories/my_assignment_repository.dart';
import 'package:ebook/features/student_features/my_books/domain/parameters/book_params.dart';
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
        await repository.getMyAssignments(p!.pageNumber, pageSize: p.pageSize!);
    return res;
  }
}
