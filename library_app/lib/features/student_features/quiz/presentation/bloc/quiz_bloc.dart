import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../domain/entities/question.dart';
import '../../domain/params/quiz_parameters.dart';

import '../../../../../core/constants.dart';
import '../../data/models/questions_summary_response.dart';
import '../../domain/usecases/get_all_questions_use_case.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final GetAllQuestionsUseCase getUseCase;
  int pageKey = 1;
  final PagingController<int, Question> pagingController =
      PagingController(firstPageKey: 0);

  QuizBloc(this.getUseCase) : super(QuizInitial()) {
    on<QuizEvent>((event, emit) async {
      if (event is FetchQuestions) {
        final params = QuizParameters(
            pageNumber: pageKey,
            pageSize: AppConstants.pageSize,
            bookID: event.bookID);
        try {
          emit(GetQuizLoading());
          final newItems = await getUseCase.call(p: params);
          newItems.fold((l) => GetQuizError(message: l.message), (r) {
            final isLastPage = !r.nextPage!;
            if (isLastPage) {
              pagingController.value.itemList?.clear();
              pagingController.appendLastPage(r.data);
            } else {
              pagingController.appendPage(r.data, pageKey);
              pageKey++;
            }
            emit(GetQuizLoaded(questionsSummary: r));
          });
        } catch (error) {
          pagingController.error = error;
        }
      }
    });
  }
}
