import 'package:dartz/dartz.dart';

import '../../../../../core/network/failure.dart';
import '../../../../../core/uscecase/usecase.dart';
import '../entities/request/assignment_post_request.dart';
import '../repositories/assignment_repository.dart';

class AddNewAssignmentUseCase
    extends UseCase<Either<Failure, String>, AssignmentPostRequestBody> {
  final IAssignmentRepository repository;
  AddNewAssignmentUseCase(this.repository);
  @override
  Future<Either<Failure, String>> call({AssignmentPostRequestBody? p}) async {
    return await repository.addAssignment(p!);
  }
}
