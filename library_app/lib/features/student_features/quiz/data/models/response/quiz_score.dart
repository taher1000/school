// To parse this JSON data, do
//
//     final quizScoreModel = quizScoreModelFromJson(jsonString);

import 'package:library_app/features/student_features/quiz/domain/entities/response/quiz_score.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

List<QuizScoreModel> quizScoreModelFromJson(String str) =>
    List<QuizScoreModel>.from(
        json.decode(str).map((x) => QuizScoreModel.fromJson(x)));

class QuizScoreModel extends QuizScore {
  QuizScoreModel({
    required super.title,
    required super.totalAnswerPoint,
    required super.totalQuizPoint,
    required super.answerPercentage,
    required super.hasResult,
    required super.hasPassed,
    required super.answerDate,
  });

  factory QuizScoreModel.fromJson(Map<String, dynamic> json) => QuizScoreModel(
        title: json["title"],
        totalAnswerPoint: json["totalAnswerPoint"],
        totalQuizPoint: json["totalQuizPoint"],
        answerPercentage: json["answerPercentage"],
        hasResult: json["hasResult"],
        hasPassed: json["hasPassed"],
        answerDate: DateTime.parse(json["answerDate"]),
      );
}
