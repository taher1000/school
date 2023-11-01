import 'dart:convert';


import '../../domain/entities/question.dart';
import '../../domain/entities/question_choice.dart';
import 'question_choice.dart';

List<Question> questionFromJson(String str) =>
    List<Question>.from(json.decode(str).map((x) => QuestionModel.fromJson(x)));

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
    required super.questionCategory,
    required super.questionType,
    required super.isActive,
    required super.title,
    required super.description,
    required super.hasPassed,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        id: json["id"],
        bookId: json["bookID"],
        bookLevel: json["bookLevel"],
        questionCategory: json["questionCategory"],
        questionType: json["questionType"],
        englishName: json["englishName"],
        arabicName: json["arabicName"],
        orderNumber: json["orderNumber"],
        point: json["point"],
        isActive: json["isActive"],
        title: json["title"],
        description: json["description"],
        hasPassed: json["hasPassed"],
        questionChoices: List<Choice>.from(
            json["questionChoices"].map((x) => ChoiceModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bookID": bookId,
        "bookLevel": bookLevel,
        "questionCategory": questionCategory,
        "questionType": questionType,
        "englishName": englishName,
        "arabicName": arabicName,
        "orderNumber": orderNumber,
        "point": point,
        "isActive": isActive,
        "title": title,
        "description": description,
        "hasPassed": hasPassed,
        "questionChoices":
            (questionChoices).map((x) => x.toModel().toJson()).toList()
        // List<QuestionChoice>.from(questionChoices.map((x) => x.toJson())),
      };
}
