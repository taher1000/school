import 'package:dartz/dartz.dart';
import '../../../../../core/network/failure.dart';

import '../../../../../core/uscecase/usecase.dart';
import '../repositories/assignment_repository.dart';

class DeleteAssignmentUseCase extends UseCase<Either<Failure, String>, String> {
  final IAssignmentRepository repository;
  DeleteAssignmentUseCase(this.repository);
  @override
  Future<Either<Failure, String>> call({String? p}) async {
    return await repository.deleteAssignment(p!);
  }
}
