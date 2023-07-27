import 'package:equatable/equatable.dart';

class Student extends Equatable {
  final String name;
  final int allAssignments;
  final int completedAssignments;
  final int remainingAssignments;
  final int readingAssignments;
  final int completedReadingAssignments;
  final int listeningAssignments;
  final int completedListeningAssignments;
  final int tests;
  final int completedTests;
  final int numberOfTasks;
  final int completedTasks;
  final int remainingTasks;

  Student({
    required this.name,
    required this.allAssignments,
    required this.completedAssignments,
    required this.remainingAssignments,
    required this.readingAssignments,
    required this.completedReadingAssignments,
    required this.listeningAssignments,
    required this.completedListeningAssignments,
    required this.tests,
    required this.completedTests,
    required this.numberOfTasks,
    required this.completedTasks,
    required this.remainingTasks,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        name,
        allAssignments,
        completedAssignments,
        remainingAssignments,
        readingAssignments,
        completedReadingAssignments,
        listeningAssignments,
        completedListeningAssignments,
        tests,
        completedTests,
        numberOfTasks,
        completedTasks,
        remainingTasks,
      ];
}
