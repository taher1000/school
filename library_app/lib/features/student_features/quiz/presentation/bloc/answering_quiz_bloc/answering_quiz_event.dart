part of 'answering_quiz_bloc.dart';

sealed class AnsweringQuizEvent extends Equatable {
  const AnsweringQuizEvent();

  @override
  List<Object> get props => [];
}

class FinishQuizEvent extends AnsweringQuizEvent {
  final String bookId;
  final String assignmentId;
  final String questionCategoryId;

  const FinishQuizEvent({
    required this.bookId,
    required this.assignmentId,
    required this.questionCategoryId,
  });

  @override
  List<Object> get props => [
        bookId,
        assignmentId,
        questionCategoryId,
      ];
}

class AnswerQuestionEvent extends AnsweringQuizEvent {
  final ChoiceAnswer choice;

  const AnswerQuestionEvent({
    required this.choice,
  });

  @override
  List<Object> get props => [
        choice,
      ];
}
