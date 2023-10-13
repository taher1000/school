import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:library_app/core/enums/request_status.dart';
import 'package:library_app/features/student_features/quiz/domain/entities/question_choice.dart';

import '../../../domain/entities/request/choice_answer.dart';
import '../../../domain/entities/request/finish_quiz_answer.dart';
import '../../../domain/usecases/finish_quiz_use_case.dart';

part 'answering_quiz_event.dart';
part 'answering_quiz_state.dart';

class AnsweringQuizBloc extends Bloc<AnsweringQuizEvent, AnsweringQuizState> {
  final FinishQuizUseCase finishQuizUseCase;
  List<ChoiceAnswer> questionAnswers = [];
  int currentQuestionNumber = 0;
  AnsweringQuizBloc(this.finishQuizUseCase)
      : super(const AnsweringQuizState(
          requestStatus: RequestStatus.initial,
          errorMessage: "",
          questionAnswers: [],
          successMessage: "",
          currentQuestionNumber: 0,
        )) {
    on<AnsweringQuizEvent>((event, emit) async {
      if (event is AnswerQuestionEvent) {
        questionAnswers.add(event.choice);
        currentQuestionNumber++;
        return emit(state.copyWith(
          errorMessage: "",
          successMessage: "",
          requestStatus: RequestStatus.initial,
          questionAnswers: questionAnswers,
          currentQuestionNumber: currentQuestionNumber,
        ));
      } else if (event is FinishQuizEvent) {
        emit(FinishQuizLoadingState(
          requestStatus: RequestStatus.loading,
          questionAnswers: state.questionAnswers,
          currentQuestionNumber: state.currentQuestionNumber,
        ));
        final response = await finishQuizUseCase(
            p: FinishQuizAnswer(
          assignmentId: event.assignmentId,
          bookId: event.bookId,
          choiceAnswer: state.questionAnswers,
          questionCategoryId: event.questionCategoryId,
        ));
        response.fold(
            (l) => emit(state.copyWith(
                  errorMessage: state.errorMessage,
                  requestStatus: RequestStatus.error,
                  questionAnswers: questionAnswers,
                  successMessage: "",
                  currentQuestionNumber: currentQuestionNumber,
                )), (r) {
          // emit(AnsweringQuizState(
          //   errorMessage: "",
          //   requestStatus: RequestStatus.success,
          //   questionAnswers: questionAnswers,
          //   successMessage: r.message!,
          //   currentQuestionNumber: currentQuestionNumber,
          // ));
          return emit(state.copyWith(
            errorMessage: "",
            successMessage: r.message!,
            requestStatus: RequestStatus.success,
            questionAnswers: questionAnswers,
            currentQuestionNumber: currentQuestionNumber,
          ));
        });
      }
    });
  }
}
