import '../../domain/entities/assignment_statistics.dart';

class AssignmentStatisticsModel extends AssignmentStatistics {
  const AssignmentStatisticsModel({
    required super.bookId,
    required super.title,
    required super.description,
    required super.imageId,
    required super.studentId,
    required super.studentEnglishName,
    required super.studentArabicName,
    required super.assignment,
    required super.assignmentCompleted,
    required super.assignmentRemaining,
    required super.totalPoints,
  });

  factory AssignmentStatisticsModel.fromJson(Map<String, dynamic> json) =>
      AssignmentStatisticsModel(
        bookId: json["bookID"],
        title: json["title"],
        description: json["description"],
        imageId: json["imageID"],
        studentId: json["studentID"],
        studentEnglishName: json["studentEnglishName"],
        studentArabicName: json["studentArabicName"],
        assignment: json["assignment"],
        assignmentCompleted: json["assignmentCompleted"],
        assignmentRemaining: json["assignmentRemaining"],
        totalPoints: json["totalPoint"],
      );

  Map<String, dynamic> toJson() => {
        "bookID": bookId,
        "title": title,
        "description": description,
        "imageID": imageId,
        "studentID": studentId,
        "studentEnglishName": studentEnglishName,
        "studentArabicName": studentArabicName,
        "assignment": assignment,
        "assignmentCompleted": assignmentCompleted,
        "assignmentRemaining": assignmentRemaining,
        "totalPoint": totalPoints,
      };
}
