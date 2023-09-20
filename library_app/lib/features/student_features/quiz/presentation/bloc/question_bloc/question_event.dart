part of 'question_bloc.dart';

sealed class QuestionEvent extends Equatable {
  const QuestionEvent();

  @override
  List<Object> get props => [];
}

class AddQuestionAnswerEvent extends QuestionEvent {
  final QuestionAnswer questionAnswer;

  const AddQuestionAnswerEvent({
    required this.questionAnswer,
  });

  @override
  List<Object> get props => [
        questionAnswer,
      ];
}

class FinishQuizEvent extends QuestionEvent {
  const FinishQuizEvent();
}
