import '../../domain/entities/assignment.dart';

class AssignmentModel extends Assignment {
  const AssignmentModel({
    required super.assignmentId,
    required super.englishName,
    required super.arabicName,
    required super.startDate,
    required super.endDate,
  });

  factory AssignmentModel.fromJson(Map<String, dynamic> json) =>
      AssignmentModel(
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
