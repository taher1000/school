import 'package:equatable/equatable.dart';
import 'package:library_app/features/student_features/quiz/domain/entities/request/choice_answer.dart';

import 'question_choice.dart';

class Question extends Equatable {
  final String id;
  final String bookId;
  final int bookLevel;
  final String questionCategory;
  final String questionType;
  final String englishName;
  final String arabicName;
  final int orderNumber;
  final int point;
  final bool isActive;
  final String title;
  final String description;
  final bool hasPassed;
  final List<Choice> questionChoices;

  const Question({
    required this.id,
    required this.bookId,
    required this.bookLevel,
    required this.questionCategory,
    required this.questionType,
    required this.englishName,
    required this.arabicName,
    required this.orderNumber,
    required this.point,
    required this.isActive,
    required this.title,
    required this.description,
    required this.hasPassed,
    required this.questionChoices,
  });

  @override
  List<Object> get props => [
        id,
        bookId,
        bookLevel,
        questionCategory,
        questionType,
        englishName,
        arabicName,
        orderNumber,
        point,
        isActive,
        title,
        description,
        hasPassed,
        questionChoices
      ];
}
