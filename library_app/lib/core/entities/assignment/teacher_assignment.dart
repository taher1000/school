import 'package:equatable/equatable.dart';

class TeacherAssignment extends Equatable {
  final String assignmentId;
  final String englishName;
  final String arabicName;
  final DateTime startDate;
  final DateTime endDate;

  const TeacherAssignment({
    required this.assignmentId,
    required this.englishName,
    required this.arabicName,
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object?> get props => [
        assignmentId,
        englishName,
        arabicName,
        startDate,
        endDate,
      ];
}
