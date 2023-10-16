import 'package:dartz/dartz.dart';
import 'package:library_app/features/student_features/quiz/domain/entities/question.dart';
import '../../../../../core/network/failure.dart';
import '../../../../../core/uscecase/usecase.dart';
import '../params/quiz_parameters.dart';
import '../repositories/question_repository.dart';

class GetAllQuestionsUseCase
    extends UseCase<Either<Failure, List<Question>>, QuizParameters> {
  final IQuizRepository repository;
  GetAllQuestionsUseCase(this.repository);
  @override
  Future<Either<Failure, List<Question>>> call({QuizParameters? p}) async {
    return await repository.getGeneralQuestions(p!.quizType,
        assignmentID: p.assignmentID, bookID: p.bookID);
  }
}
