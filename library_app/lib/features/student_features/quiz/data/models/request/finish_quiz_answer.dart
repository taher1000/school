// To parse this JSON data, do
//
//     final question = questionFromJson(jsonString);

import 'package:library_app/features/student_features/quiz/data/models/request/choice_answer.dart';
import 'package:library_app/features/student_features/quiz/domain/entities/request/choice_answer.dart';

import '../../../domain/entities/request/finish_quiz_answer.dart';

class FinishQuizAnswerModel extends FinishQuizAnswer {
  FinishQuizAnswerModel({
    required super.assignmentId,
    required super.bookId,
    required super.questionCategoryId,
    required super.choiceAnswer,
  });

  Map<String, dynamic> toJson() => {
        "assignmentID": assignmentId,
        "bookID": bookId,
        "questionCategoryID": questionCategoryId,
        "choiceAnswer": (choiceAnswer).map((x) => x.toModel().toJson()).toList()
      };
}
