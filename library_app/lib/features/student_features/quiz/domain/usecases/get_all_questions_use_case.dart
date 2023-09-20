import 'package:dartz/dartz.dart';
import '../../../../../core/network/failure.dart';
import '../../../../../core/uscecase/usecase.dart';
import '../../data/models/questions_summary_response.dart';
import '../params/quiz_parameters.dart';
import '../repositories/question_repository.dart';

class GetAllQuestionsUseCase extends UseCase<
    Either<Failure, QuestionsSummaryResponsePage>, QuizParameters> {
  final IQuizRepository repository;
  GetAllQuestionsUseCase(this.repository);
  @override
  Future<Either<Failure, QuestionsSummaryResponsePage>> call(
      {QuizParameters? p}) async {
    return await repository.getQuestions(p!.pageNumber,
        pageSize: p.pageSize, bookID: p.bookID);
  }
}
