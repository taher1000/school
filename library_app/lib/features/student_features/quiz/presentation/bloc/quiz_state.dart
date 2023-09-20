part of 'quiz_bloc.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object> get props => [];
}

class QuizInitial extends QuizState {}

class GetQuiz extends QuizState {}

class GetQuizLoading extends QuizState {}

class GetQuizError extends QuizState {
  final String message;
  const GetQuizError({required this.message});
}

class GetQuizEmpty extends QuizState {}

class GetQuizLoaded extends QuizState {
  final QuestionsSummaryResponsePage questionsSummary;
  const GetQuizLoaded({
    required this.questionsSummary,
  });
}
