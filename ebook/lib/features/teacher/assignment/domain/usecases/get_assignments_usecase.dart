import 'package:dartz/dartz.dart';
import '../../../../../core/network/failure.dart';
import '../../../../../core/params/pagination_params.dart';
import '../../../../../core/uscecase/usecase.dart';
import '../entities/assignment.dart';
import '../repositories/assignment_repository.dart';

class GetAssignmentsUseCase
    extends UseCase<Either<Failure, List<Assignment>>, PaginationParameters> {
  final IAssignmentRepository repository;
  GetAssignmentsUseCase(this.repository);
  @override
  Future<Either<Failure, List<Assignment>>> call(
      {PaginationParameters? p}) async {
    return await repository.getAssignments(p!.pageNumber, pageSize: p.pageSize);
  }
}
