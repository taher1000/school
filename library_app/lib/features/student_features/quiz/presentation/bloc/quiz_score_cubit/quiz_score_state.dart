part of 'quiz_score_cubit.dart';

sealed class QuizScoreState extends Equatable {
  const QuizScoreState();

  @override
  List<Object> get props => [];
}

final class QuizScoreInitialState extends QuizScoreState {}

final class QuizScoreLoadingState extends QuizScoreState {}

final class QuizScoreLoadedState extends QuizScoreState {
  final List<QuizScoreModel> quizScore;
  const QuizScoreLoadedState(this.quizScore);
}

final class QuizScoreErrorState extends QuizScoreState {
  final String message;
  const QuizScoreErrorState(this.message);
}
