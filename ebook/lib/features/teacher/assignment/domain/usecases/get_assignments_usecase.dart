import 'package:dartz/dartz.dart';
import 'package:ebook/features/teacher/assignment/data/models/assignment_summary_response.dart';
import '../../../../../core/network/failure.dart';
import '../../../../../core/params/pagination_params.dart';
import '../../../../../core/uscecase/usecase.dart';
import '../entities/assignment.dart';
import '../repositories/assignment_repository.dart';

class GetAssignmentsUseCase extends UseCase<
    Either<Failure, AssignmentSummaryResponsePage>, PaginationParameters> {
  final IAssignmentRepository repository;
  GetAssignmentsUseCase(this.repository);
  @override
  Future<Either<Failure, AssignmentSummaryResponsePage>> call(
      {PaginationParameters? p}) async {
    return await repository.getAssignments(p!.pageNumber, pageSize: p.pageSize);
  }
}
