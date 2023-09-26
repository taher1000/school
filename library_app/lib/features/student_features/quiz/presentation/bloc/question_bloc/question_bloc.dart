import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/request/question_answer.dart';

import '../../../domain/usecases/finish_quiz_use_case.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final FinishQuizUseCase finishQuizUseCase;
  List<QuestionAnswer> questionAnswers = [];
  QuestionBloc(this.finishQuizUseCase)
      : super(QuestionInitial(questionAnswers: [], questionNumber: 1)) {
    on<QuestionEvent>((event, emit) async {
      if (event is AddQuestionAnswerEvent) {
        questionAnswers.add(event.questionAnswer);

        emit(state.copyWith(
            questionNumber: state.questionNumber,
            questionAnswers: state.questionAnswers..add(event.questionAnswer)));
        emit(QuestionAnswerAddedState(
            questionNumber: state.questionNumber,
            questionAnswers: state.questionAnswers..add(event.questionAnswer)));
        state.questionNumber = state.questionNumber + 1;
      } else if (event is FinishQuizEvent) {
        emit(FinishQuizLoadingState(
            questionNumber: state.questionNumber,
            questionAnswers: state.questionAnswers));
        final response = await finishQuizUseCase(p: state.questionAnswers);
        response.fold(
            (l) => FinishQuizFailedState(
                questionNumber: state.questionNumber,
                l.message,
                questionAnswers: state.questionAnswers), (r) {
          emit(FinishQuizSuccessState(
              questionNumber: state.questionNumber,
              message: r,
              questionAnswers: state.questionAnswers));
        });
      }
    });
  }
}
