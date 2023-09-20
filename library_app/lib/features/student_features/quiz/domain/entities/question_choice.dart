import 'package:equatable/equatable.dart';

import '../../data/models/question_choice.dart';

class QuestionChoice extends Equatable {
  final String questionChoiceId;
  final String text;

  const QuestionChoice({
    required this.questionChoiceId,
    required this.text,
  });

  QuestionChoiceModel toModel() => QuestionChoiceModel(
        questionChoiceId: questionChoiceId,
        text: text,
      );

  @override
  List<Object?> get props => [
        questionChoiceId,
        text,
      ];
}
