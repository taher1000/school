import 'package:dartz/dartz.dart';
import 'package:library_app/features/student_features/quiz/domain/entities/request/question_answer.dart';

import '../../../../../core/network/failure.dart';
import '../../../../../core/uscecase/usecase.dart';
import '../repositories/question_repository.dart';

class FinishQuizUseCase
    extends UseCase<Either<Failure, String>, List<QuestionAnswer>> {
  final IQuizRepository repository;
  FinishQuizUseCase(this.repository);
  @override
  Future<Either<Failure, String>> call({List<QuestionAnswer>? p}) async {
    return await repository.finishQuiz(p!);
  }
}
