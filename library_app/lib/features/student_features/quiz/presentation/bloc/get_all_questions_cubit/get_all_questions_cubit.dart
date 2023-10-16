import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:library_app/core/enums/request_status.dart';
import 'package:library_app/features/student_features/quiz/domain/params/quiz_parameters.dart';

import '../../../data/enums/quiz_type_enum.dart';
import '../../../domain/entities/question.dart';
import '../../../domain/usecases/get_all_questions_use_case.dart';

part 'get_all_questions_state.dart';

class GetAllQuestionsCubit extends Cubit<GetAllQuestionsState> {
  final GetAllQuestionsUseCase getUseCase;

  GetAllQuestionsCubit(this.getUseCase)
      : super(const GetAllQuestionsState(
            requestStatus: RequestStatus.loading,
            errorMessage: "",
            questions: []));

  Future<void> getAllQuestions(
    String bookID,
    String assignmentID,
    QuizTypeEnum quizType,
  ) async {
    final result = await getUseCase(
        p: QuizParameters(
            assignmentID: assignmentID, bookID: bookID, quizType: quizType));
    result.fold(
      (failure) => emit(state.copyWith(
          requestStatus: RequestStatus.error,
          errorMessage: failure.message,
          questions: [])),
      (questions) => emit(state.copyWith(
          requestStatus: RequestStatus.success,
          errorMessage: "",
          questions: questions)),
    );
  }
}
