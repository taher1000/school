import 'package:dartz/dartz.dart';
import 'package:library_app/core/models/assignment/student_assignment_summary_response.dart';

import '../../../../../core/network/failure.dart';

abstract class IMyAssignmentRepository {
  Future<Either<Failure, StudentAssignmentSummaryResponsePage>>
      getMyAssignments(int pageNumber, {required int pageSize});
}