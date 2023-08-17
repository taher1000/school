import 'package:dartz/dartz.dart';

import '../../../../core/network/failure.dart';
import '../../data/models/response/all_student_summary_response.dart';

abstract class IGetAllStudentRepository {
  Future<Either<Failure, AllStudentsSummaryResponsePage>> getStudents(
    int pageNumber, {
    int pageSize,
    required int sectionID,
    required int classYearID,
  });
  // Future<Either<Failure, StudentSummaryResponsePage>> getStudent(String id);
}
