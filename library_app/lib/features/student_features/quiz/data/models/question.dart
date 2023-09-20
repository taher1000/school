import 'package:library_app/features/student_features/quiz/data/models/question_choice.dart';

import '../../domain/entities/question.dart';

class QuestionModel extends Question {
  const QuestionModel({
    required super.id,
    required super.bookId,
    required super.bookLevel,
    required super.englishName,
    required super.arabicName,
    required super.orderNumber,
    required super.point,
    required super.questionChoices,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        id: json["id"],
        bookId: json["bookID"],
        bookLevel: json["bookLevel"],
        englishName: json["englishName"],
        arabicName: json["arabicName"],
        orderNumber: json["orderNumber"],
        point: json["point"],
        questionChoices: List<QuestionChoiceModel>.from(json["questionChoices"]
            .map((x) => QuestionChoiceModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bookID": bookId,
        "bookLevel": bookLevel,
        "englishName": englishName,
        "arabicName": arabicName,
        "orderNumber": orderNumber,
        "point": point,
        "questionChoices":
            (questionChoices).map((x) => x.toModel().toJson()).toList()
        // List<QuestionChoice>.from(questionChoices.map((x) => x.toJson())),
      };
}
