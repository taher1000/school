import 'package:ebook/features/teacher_features/assignment/data/models/request/assignment_post_request.dart';
import 'package:equatable/equatable.dart';

import 'book_collection_body.dart';
import 'student_list.dart';

class AssignmentPostRequestBody extends Equatable {
  final String? englishName;
  final String? arabicName;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<StudentList>? studentList;
  final List<BookCollection>? bookCollection;

  const AssignmentPostRequestBody({
    this.englishName,
    this.arabicName,
    this.startDate,
    this.endDate,
    this.studentList,
    this.bookCollection,
  });
  AssignmentPostRequestBodyModel toModel() => AssignmentPostRequestBodyModel(
        englishName: englishName,
        arabicName: arabicName,
        startDate: startDate,
        endDate: endDate,
        studentList: studentList,
        bookCollection: bookCollection,
      );

  @override
  List<Object?> get props => [
        englishName,
        arabicName,
        startDate,
        endDate,
        studentList,
        bookCollection,
      ];
}
