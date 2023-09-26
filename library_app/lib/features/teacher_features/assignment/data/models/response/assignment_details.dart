import '../../../../../students/data/models/student.dart';
import '../../../domain/entities/response/assignment_details.dart';

import '../../../../../../core/models/assignment/teacher_assignment_model.dart';
import '../../../../../../core/models/book/book.dart';

class AssignmentDetailsModel extends AssignmentDetails {
  const AssignmentDetailsModel({
    required super.assignment,
    required super.students,
    required super.books,
  });

  factory AssignmentDetailsModel.fromJson(Map<String, dynamic> json) =>
      AssignmentDetailsModel(
        assignment: TeacherAssignmentModel.fromJson(json["assignment"]),
        students: List<StudentModel>.from(
            json["students"].map((x) => StudentModel.fromJson(x))),
        books: List<BookModel>.from(
            json["books"].map((x) => BookModel.fromJson(x))),
      );
}
