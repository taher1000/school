import '../../entities/assignment/student_assignment.dart';
import 'dart:convert';

List<StudentAssignment> studentAssignmentFromJson(String str) =>
    List<StudentAssignment>.from(
        json.decode(str).map((x) => StudentAssignmentModel.fromJson(x)));

class StudentAssignmentModel extends StudentAssignment {
  const StudentAssignmentModel({
    required super.assignmentId,
    required super.id,
    required super.title,
    required super.description,
    required super.bookLevel,
    required super.image,
    required super.bookLanguage,
    required super.pageCount,
    required super.wordCount,
    required super.isActive,
    required super.authorName,
    required super.authorAddress,
    required super.publisherName,
    required super.publisherAddress,
    required super.imageId,
    required super.hasListening,
    required super.hasReading,
    required super.hasReadingCompleted,
    required super.hasListeningCompleted,
    required super.showAdvanceQuestion,
    required super.hasGeneralLevelPass,
    required super.hasDeductiveLevelPass,
    required super.hasEvaluativeLevelPass,
    required super.assignmentEnglishName,
    required super.assignmentArabicName,
    required super.hasAssignmentExpired,
    required super.assignmentStartDate,
    required super.assignmentEndDate,
    required super.assignmentCreatedDate,
  });

  factory StudentAssignmentModel.fromJson(Map<String, dynamic> json) =>
      StudentAssignmentModel(
        assignmentId: json["assignmentID"],
        assignmentEnglishName: json["assignmentEnglishName"],
        assignmentArabicName: json["assignmentArabicName"],
        assignmentStartDate: DateTime.parse(json["assignmentStartDate"]),
        assignmentEndDate: DateTime.parse(json["assignmentEndDate"]),
        hasAssignmentExpired: json["hasAssignmentExpired"],
        assignmentCreatedDate: DateTime.parse(json["assignmentCreatedDate"]),
        id: json["bookID"],
        title: json["title"],
        description: json["description"],
        bookLevel: json["bookLevel"],
        image: json["image"],
        bookLanguage: json["bookLanguage"],
        pageCount: json["pageCount"],
        wordCount: json["wordCount"],
        hasReading: json["hasReading"],
        hasListening: json["hasListening"],
        hasReadingCompleted: json["hasReadingCompleted"],
        hasListeningCompleted: json["hasListeningCompleted"],
        isActive: json["isActive"],
        authorName: json["authorName"],
        authorAddress: json["authorAddress"],
        publisherName: json["publisherName"],
        publisherAddress: json["publisherAddress"],
        imageId: json["imageID"],
        hasGeneralLevelPass: json["hasGeneralLevelPass"],
        hasDeductiveLevelPass: json["hasDeductiveLevelPass"],
        hasEvaluativeLevelPass: json["hasEvaluativeLevelPass"],
        showAdvanceQuestion: json["showAdvanceQuestion"],
      );
}
