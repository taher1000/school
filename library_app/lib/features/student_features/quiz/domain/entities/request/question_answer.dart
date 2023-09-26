import 'package:equatable/equatable.dart';
import '../../../data/models/request/question_answer.dart';

class QuestionAnswer extends Equatable {
  final String questionId;
  final String questionChoiceId;

  const QuestionAnswer({
    required this.questionId,
    required this.questionChoiceId,
  });

  QuestionAnswerModel toModel() => QuestionAnswerModel(
        questionId: questionId,
        questionChoiceId: questionChoiceId,
      );

  @override
  List<Object?> get props => [
        questionId,
        questionChoiceId,
      ];
}
