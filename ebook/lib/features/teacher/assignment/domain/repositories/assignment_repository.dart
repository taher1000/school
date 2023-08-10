import 'package:dartz/dartz.dart';

import '../../../../../core/network/failure.dart';
import '../entities/assignment.dart';

abstract class IAssignmentRepository {
  Future<Either<Failure, List<Assignment>>> getAssignments(int pageNumber,
      {int pageSize});
  // Future<Either<Failure, AssignmentSummaryResponsePage>> getAssignment(String id);
}
