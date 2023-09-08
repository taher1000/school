import 'package:dartz/dartz.dart';

import '../../../../core/network/failure.dart';
import '../../../../core/uscecase/usecase.dart';
import '../../data/models/response/all_student_summary_response.dart';
import '../params/student_parameters.dart';
import '../repository/student_repository.dart';

class GetAllStudentsUseCase extends UseCase<
    Either<Failure, AllStudentsSummaryResponsePage>, StudentParameters> {
  final IGetAllStudentRepository repository;
  GetAllStudentsUseCase(this.repository);
  @override
  Future<Either<Failure, AllStudentsSummaryResponsePage>> call(
      {StudentParameters? p}) async {
    return await repository.getStudents(p!.pageNumber,
        pageSize: p.pageSize,
        classYearID: p.classYearID,
        sectionID: p.sectionID);
  }
}
