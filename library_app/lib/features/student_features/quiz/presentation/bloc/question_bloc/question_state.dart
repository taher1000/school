part of 'question_bloc.dart';

class QuestionState extends Equatable {
  List<QuestionAnswer> questionAnswers = [];
  int questionNumber = 1;
  QuestionState({
    required this.questionAnswers,
    required this.questionNumber,
  });

  QuestionState copyWith({
    List<QuestionAnswer>? questionAnswers,
    int? questionNumber,
  }) {
    return QuestionState(
      questionAnswers: questionAnswers ?? this.questionAnswers,
      questionNumber: questionNumber ?? this.questionNumber,
    );
  }

  @override
  List<Object> get props => [];
}

final class QuestionInitial extends QuestionState {
  QuestionInitial(
      {required super.questionAnswers, required super.questionNumber});
}

final class QuestionAnswerAddedState extends QuestionState {
  QuestionAnswerAddedState(
      {required super.questionAnswers, required super.questionNumber});
}

final class FinishQuizLoadingState extends QuestionState {
  FinishQuizLoadingState(
      {required super.questionAnswers, required super.questionNumber});
}

final class FinishQuizSuccessState extends QuestionState {
  final String message;

  FinishQuizSuccessState(
      {required this.message,
      required super.questionAnswers,
      required super.questionNumber});
}

final class FinishQuizFailedState extends QuestionState {
  final String message;
  FinishQuizFailedState(this.message,
      {required super.questionAnswers, required super.questionNumber});
}
