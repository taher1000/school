import 'package:dartz/dartz.dart';
import '../entities/response/assignment_details.dart';
import '../../../../../core/network/failure.dart';
import '../../../../../core/uscecase/usecase.dart';
import '../repositories/assignment_repository.dart';

class GetAssignmentByIDUseCase
    extends UseCase<Either<Failure, AssignmentDetails>, String> {
  final IAssignmentRepository repository;
  GetAssignmentByIDUseCase(this.repository);
  @override
  Future<Either<Failure, AssignmentDetails>> call({String? p}) async {
    return await repository.getAssignmentByID(p!);
  }
}
