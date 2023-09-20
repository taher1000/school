import 'package:equatable/equatable.dart';

import 'question_choice.dart';

class Question extends Equatable {
  final String id;
  final String bookId;
  final int bookLevel;
  final String englishName;
  final String arabicName;
  final int orderNumber;
  final int point;
  final List<QuestionChoice> questionChoices;

  const Question({
    required this.id,
    required this.bookId,
    required this.bookLevel,
    required this.englishName,
    required this.arabicName,
    required this.orderNumber,
    required this.point,
    required this.questionChoices,
  });

  @override
  List<Object?> get props => [
        id,
        bookId,
        bookLevel,
        englishName,
        arabicName,
        orderNumber,
        point,
        questionChoices,
      ];
}
