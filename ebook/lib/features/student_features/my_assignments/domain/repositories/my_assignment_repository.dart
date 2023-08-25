import 'package:dartz/dartz.dart';
import 'package:ebook/core/models/assignment/student_assignment_summary_response.dart';

import '../../../../../core/models/assignment/teacher_assignment_summary_response.dart';
import '../../../../../core/network/failure.dart';

abstract class IMyAssignmentRepository {
  Future<Either<Failure, StudentAssignmentSummaryResponsePage>>
      getMyAssignments(int pageNumber, {int pageSize});
}
