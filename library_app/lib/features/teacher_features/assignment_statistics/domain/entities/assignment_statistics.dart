import 'package:equatable/equatable.dart';

class AssignmentStatistics extends Equatable {
  final String bookId;
  final String title;
  final String description;
  final String imageId;
  final String studentId;
  final String studentEnglishName;
  final String studentArabicName;
  final int assignment;
  final int assignmentCompleted;
  final int assignmentRemaining;

  const AssignmentStatistics({
    required this.bookId,
    required this.title,
    required this.description,
    required this.imageId,
    required this.studentId,
    required this.studentEnglishName,
    required this.studentArabicName,
    required this.assignment,
    required this.assignmentCompleted,
    required this.assignmentRemaining,
  });

  @override
  List<Object?> get props => [
        bookId,
        title,
        description,
        imageId,
        studentId,
        studentEnglishName,
        studentArabicName,
        assignment,
        assignmentCompleted,
        assignmentRemaining,
      ];
}
