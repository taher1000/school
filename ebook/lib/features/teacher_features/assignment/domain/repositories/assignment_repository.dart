import 'package:dartz/dartz.dart';
import '../../data/models/assignment_summary_response.dart';

import '../../../../../core/network/failure.dart';
import '../entities/assignment.dart';
import '../entities/request/book_collection_body.dart';

abstract class IAssignmentRepository {
  Future<Either<Failure, AssignmentSummaryResponsePage>> getAssignments(
      int pageNumber,
      {int pageSize});
  Future<Either<Failure, AssignmentSummaryResponsePage>> addAssignment(
      BookCollection bookCollection);
}
