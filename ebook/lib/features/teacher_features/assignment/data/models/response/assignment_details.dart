import 'package:ebook/features/books/data/models/book.dart';
import 'package:ebook/features/students/data/models/student.dart';
import 'package:ebook/features/teacher_features/assignment/data/models/assignment_model.dart';
import 'package:ebook/features/teacher_features/assignment/domain/entities/response/assignment_details.dart';

class AssignmentDetailsModel extends AssignmentDetails {
  const AssignmentDetailsModel({
    required super.assignment,
    required super.students,
    required super.books,
  });

  factory AssignmentDetailsModel.fromJson(Map<String, dynamic> json) =>
      AssignmentDetailsModel(
        assignment: AssignmentModel.fromJson(json["assignment"]),
        students: List<StudentModel>.from(
            json["students"].map((x) => StudentModel.fromJson(x))),
        books: List<BookModel>.from(
            json["books"].map((x) => BookModel.fromJson(x))),
      );
}
