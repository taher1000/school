import '../../domain/entities/question_choice.dart';

class QuestionChoiceModel extends QuestionChoice {
  const QuestionChoiceModel({
    required super.questionChoiceId,
    required super.text,
  });

  factory QuestionChoiceModel.fromJson(Map<String, dynamic> json) =>
      QuestionChoiceModel(
        questionChoiceId: json["questionChoiceID"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "questionChoiceID": questionChoiceId,
        "text": text,
      };
}
