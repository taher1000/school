import 'package:dartz/dartz.dart';
import 'package:ebook/features/teacher/assignment/data/models/assignment_summary_response.dart';

import '../../../../../core/network/failure.dart';
import '../entities/assignment.dart';

abstract class IAssignmentRepository {
  Future<Either<Failure, AssignmentSummaryResponsePage>> getAssignments(
      int pageNumber,
      {int pageSize});
  // Future<Either<Failure, AssignmentSummaryResponsePage>> getAssignment(String id);
}
