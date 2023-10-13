import '../../domain/entities/question_choice.dart';

class ChoiceModel extends Choice {
  const ChoiceModel({
    required super.questionChoiceId,
    required super.text,
  });

  factory ChoiceModel.fromJson(Map<String, dynamic> json) => ChoiceModel(
        questionChoiceId: json["questionChoiceID"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "questionChoiceID": questionChoiceId,
        "text": text,
      };
}
