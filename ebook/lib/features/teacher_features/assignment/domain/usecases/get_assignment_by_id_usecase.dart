import 'package:dartz/dartz.dart';
import 'package:ebook/features/teacher_features/assignment/domain/entities/response/assignment_details.dart';
import '../../data/models/assignment_summary_response.dart';
import '../../../../../core/network/failure.dart';
import '../../../../../core/params/pagination_params.dart';
import '../../../../../core/uscecase/usecase.dart';
import '../entities/assignment.dart';
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
