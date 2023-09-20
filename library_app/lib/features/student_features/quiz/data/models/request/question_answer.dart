import '../../../domain/entities/request/question_answer.dart';
import 'dart:convert';

List<QuestionAnswerModel> questionAnswerModelFromJson(String str) =>
    List<QuestionAnswerModel>.from(
        json.decode(str).map((x) => QuestionAnswerModel.fromJson(x)));

String questionAnswerModelToJson(List<QuestionAnswerModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuestionAnswerModel extends QuestionAnswer {
  const QuestionAnswerModel({
    required super.questionId,
    required super.questionChoiceId,
  });

  factory QuestionAnswerModel.fromJson(Map<String, dynamic> json) =>
      QuestionAnswerModel(
        questionId: json["questionID"],
        questionChoiceId: json["questionChoiceID"],
      );

  Map<String, dynamic> toJson() => {
        "questionID": questionId,
        "questionChoiceID": questionChoiceId,
      };
}
