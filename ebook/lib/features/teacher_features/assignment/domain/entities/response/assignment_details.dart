import 'package:equatable/equatable.dart';

import '../../../../../../core/entities/book/book.dart';
import '../../../../../students/domain/entities/student.dart';
import '../assignment.dart';

class AssignmentDetails extends Equatable {
  final Assignment assignment;
  final List<Student> students;
  final List<Book> books;

  const AssignmentDetails({
    required this.assignment,
    required this.students,
    required this.books,
  });

  @override
  List<Object?> get props => [assignment, students, books];
}
