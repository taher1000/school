part of 'answering_quiz_bloc.dart';

class AnsweringQuizState extends Equatable {
  final RequestStatus requestStatus;
  final String errorMessage;
  final String successMessage;
  final List<ChoiceAnswer> questionAnswers;
  final int currentQuestionNumber;
  const AnsweringQuizState({
    this.requestStatus = RequestStatus.initial,
    this.errorMessage = "",
    this.questionAnswers = const [],
    this.currentQuestionNumber = 0,
    this.successMessage = "",
  });

  AnsweringQuizState copyWith({
    RequestStatus? requestStatus,
    String? errorMessage,
    List<ChoiceAnswer>? questionAnswers,
    int? currentQuestionNumber,
    String? successMessage,
  }) {
    return AnsweringQuizState(
      requestStatus: requestStatus ?? this.requestStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      questionAnswers: questionAnswers ?? this.questionAnswers,
      currentQuestionNumber:
          currentQuestionNumber ?? this.currentQuestionNumber,
    );
  }

  @override
  List<Object> get props => [
        requestStatus,
        errorMessage,
        questionAnswers,
        currentQuestionNumber,
        successMessage,
      ];
}

class FinishQuizLoadingState extends AnsweringQuizState {
  const FinishQuizLoadingState({
    super.requestStatus = RequestStatus.loading,
    super.errorMessage = "",
    super.questionAnswers = const [],
    super.currentQuestionNumber = 0,
    super.successMessage = "",
  });
}
