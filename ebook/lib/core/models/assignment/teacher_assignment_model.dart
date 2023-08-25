import '../../entities/assignment/teacher_assignment.dart';

class TeacherAssignmentModel extends TeacherAssignment {
  const TeacherAssignmentModel({
    required super.assignmentId,
    required super.englishName,
    required super.arabicName,
    required super.startDate,
    required super.endDate,
  });

  factory TeacherAssignmentModel.fromJson(Map<String, dynamic> json) =>
      TeacherAssignmentModel(
        assignmentId: json["assignmentID"],
        englishName: json["englishName"],
        arabicName: json["arabicName"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
      );

  Map<String, dynamic> toJson() => {
        "assignmentID": assignmentId,
        "englishName": englishName,
        "arabicName": arabicName,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
      };
}
