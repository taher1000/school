import 'dart:convert';

import '../../../domain/entities/response/follow_up_student.dart';

class FollowUpStudentModel extends FollowUpStudent {
  const FollowUpStudentModel({
    required super.studentId,
    required super.englishName,
    required super.arabicName,
    required super.assignment,
    required super.assignmentCompleted,
    required super.assignmentRemaining,
    required super.reading,
    required super.readingCompleted,
    required super.listening,
    required super.listeningCompleted,
    required super.test,
    required super.testCompleted,
    required super.task,
    required super.taskCompleted,
    required super.taskRemaining,
  });

  factory FollowUpStudentModel.fromRawJson(String str) =>
      FollowUpStudentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FollowUpStudentModel.fromJson(Map<String, dynamic> json) =>
      FollowUpStudentModel(
        studentId: json["studentID"],
        englishName: json["englishName"],
        arabicName: json["arabicName"],
        assignment: json["assignment"],
        assignmentCompleted: json["assignmentCompleted"],
        assignmentRemaining: json["assignmentRemaining"],
        reading: json["reading"],
        readingCompleted: json["readingCompleted"],
        listening: json["listening"],
        listeningCompleted: json["listeningCompleted"],
        test: json["test"],
        testCompleted: json["testCompleted"],
        task: json["task"],
        taskCompleted: json["taskCompleted"],
        taskRemaining: json["taskRemaining"],
      );

  Map<String, dynamic> toJson() => {
        "studentID": studentId,
        "englishName": englishName,
        "arabicName": arabicName,
        "assignment": assignment,
        "assignmentCompleted": assignmentCompleted,
        "assignmentRemaining": assignmentRemaining,
        "reading": reading,
        "readingCompleted": readingCompleted,
        "listening": listening,
        "listeningCompleted": listeningCompleted,
        "test": test,
        "testCompleted": testCompleted,
        "task": task,
        "taskCompleted": taskCompleted,
        "taskRemaining": taskRemaining,
      };
}
