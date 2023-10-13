part of 'get_all_questions_cubit.dart';

class GetAllQuestionsState extends Equatable {
  final List<Question> questions;
  final RequestStatus requestStatus;
  final String errorMessage;

  const GetAllQuestionsState({
    this.questions = const [],
    this.requestStatus = RequestStatus.loading,
    this.errorMessage = "",
  });

  GetAllQuestionsState copyWith({
    List<Question>? questions,
    RequestStatus? requestStatus,
    String? errorMessage,
  }) {
    return GetAllQuestionsState(
      questions: questions ?? this.questions,
      requestStatus: requestStatus ?? this.requestStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        questions,
        requestStatus,
        errorMessage,
      ];
}
