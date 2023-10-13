import 'dart:convert';

import 'package:library_app/features/student_features/quiz/domain/entities/request/choice_answer.dart';

List<ChoiceAnswerModel> choiceAnswerModelFromJson(String str) =>
    List<ChoiceAnswerModel>.from(
        json.decode(str).map((x) => ChoiceAnswerModel.fromJson(x)));

String choiceAnswerModelToJson(List<ChoiceAnswer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toModel().toJson())));

class ChoiceAnswerModel extends ChoiceAnswer {
  const ChoiceAnswerModel({
    required super.questionId,
    required super.questionChoiceId,
  });

  factory ChoiceAnswerModel.fromJson(Map<String, dynamic> json) =>
      ChoiceAnswerModel(
        questionId: json["questionID"],
        questionChoiceId: json["questionChoiceID"],
      );

  Map<String, dynamic> toJson() => {
        "questionID": questionId,
        "questionChoiceID": questionChoiceId,
      };
}
