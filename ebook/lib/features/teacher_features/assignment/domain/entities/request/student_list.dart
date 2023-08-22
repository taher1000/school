import 'package:equatable/equatable.dart';

import '../../../data/models/request/assignment_post_request.dart';

class StudentList extends Equatable {
  final String studentId;
  final int classYearId;
  final int classSectionId;

  const StudentList({
    required this.studentId,
    required this.classYearId,
    required this.classSectionId,
  });

  StudentListModel toModel() => StudentListModel(
        studentId: studentId,
        classYearId: classYearId,
        classSectionId: classSectionId,
      );

  @override
  List<Object?> get props => [
        studentId,
        classYearId,
        classSectionId,
      ];
}
