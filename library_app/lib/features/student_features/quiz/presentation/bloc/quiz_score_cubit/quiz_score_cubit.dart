import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:library_app/features/student_features/quiz/domain/usecases/get_quiz_score_use_case.dart';

import '../../../data/models/response/quiz_score.dart';

part 'quiz_score_state.dart';

class QuizScoreCubit extends Cubit<QuizScoreState> {
  final GetQuizScoreUseCase getQuizScoreUseCase;
  QuizScoreCubit(this.getQuizScoreUseCase) : super(QuizScoreInitialState());

  Future<void> getQuizScore(String bookID) async {
    // emit(QuizScoreLoadingState());
    final result = await getQuizScoreUseCase.call(p: bookID);

    result.fold(
      (failure) {
        emit(QuizScoreErrorState(failure.message));
      },
      (quizScore) {
        emit(QuizScoreLoadedState(quizScore));
      },
    );
  }
}
