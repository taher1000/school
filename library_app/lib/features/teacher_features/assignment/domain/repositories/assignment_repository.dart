import 'package:dartz/dartz.dart';
import 'package:library_app/features/teacher_features/assignment/domain/entities/request/assignment_post_request.dart';
import 'package:library_app/features/teacher_features/assignment/domain/entities/response/assignment_details.dart';

import '../../../../../core/models/assignment/teacher_assignment_summary_response.dart';
import '../../../../../core/network/failure.dart';

abstract class IAssignmentRepository {
  Future<Either<Failure, TeacherAssignmentSummaryResponsePage>> getAssignments(
      int pageNumber,
      {int pageSize});
  Future<Either<Failure, String>> addAssignment(
      AssignmentPostRequestBody postRequestBody);

  Future<Either<Failure, AssignmentDetails>> getAssignmentByID(String id);
  Future<Either<Failure, String>> deleteAssignment(String id);
}
