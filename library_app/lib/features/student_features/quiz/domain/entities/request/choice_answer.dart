import 'package:equatable/equatable.dart';
import '../../../data/models/request/choice_answer.dart';

class ChoiceAnswer extends Equatable {
  final String questionId;
  final String questionChoiceId;

  const ChoiceAnswer({
    required this.questionId,
    required this.questionChoiceId,
  });

  ChoiceAnswerModel toModel() => ChoiceAnswerModel(
        questionId: questionId,
        questionChoiceId: questionChoiceId,
      );

  @override
  List<Object?> get props => [
        questionId,
        questionChoiceId,
      ];
}
