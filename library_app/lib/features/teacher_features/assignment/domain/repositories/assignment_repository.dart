import 'package:dartz/dartz.dart';
import '../entities/request/assignment_post_request.dart';
import '../entities/response/assignment_details.dart';

import '../../../../../core/models/assignment/teacher_assignment_summary_response.dart';
import '../../../../../core/network/failure.dart';
import '../../data/models/response/follow_up_assignment_summary_response.dart';

abstract class IAssignmentRepository {
  Future<Either<Failure, TeacherAssignmentSummaryResponsePage>> getAssignments(
      int pageNumber,
      {int pageSize});
  Future<Either<Failure, FollowUpAssignmentSummaryResponsePage>>
      getAllFollowUpStudentAssignments(int pageNumber, {required int pageSize});
  Future<Either<Failure, String>> addAssignment(
      AssignmentPostRequestBody postRequestBody);

  Future<Either<Failure, AssignmentDetails>> getAssignmentByID(String id);
  Future<Either<Failure, String>> deleteAssignment(String id);
}
