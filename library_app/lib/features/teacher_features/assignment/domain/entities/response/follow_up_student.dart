import 'package:equatable/equatable.dart';

class FollowUpStudent extends Equatable {
  final String studentId;
  final String englishName;
  final String arabicName;
  final int assignment;
  final int assignmentCompleted;
  final int assignmentRemaining;
  final int reading;
  final int readingCompleted;
  final int listening;
  final int listeningCompleted;
  final int test;
  final int testCompleted;
  final int task;
  final int taskCompleted;
  final int taskRemaining;

  const FollowUpStudent({
    required this.studentId,
    required this.englishName,
    required this.arabicName,
    required this.assignment,
    required this.assignmentCompleted,
    required this.assignmentRemaining,
    required this.reading,
    required this.readingCompleted,
    required this.listening,
    required this.listeningCompleted,
    required this.test,
    required this.testCompleted,
    required this.task,
    required this.taskCompleted,
    required this.taskRemaining,
  });

  @override
  List<Object?> get props => [
        studentId,
        englishName,
        arabicName,
        assignment,
        assignmentCompleted,
        assignmentRemaining,
        reading,
        readingCompleted,
        listening,
        listeningCompleted,
        test,
        testCompleted,
        task,
        taskCompleted,
        taskRemaining,
      ];
}
