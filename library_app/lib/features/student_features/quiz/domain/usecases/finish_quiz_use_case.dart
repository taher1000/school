import 'package:dartz/dartz.dart';
import '../../../../../core/network/api_response_model.dart';
import '../entities/request/finish_quiz_answer.dart';

import '../../../../../core/network/failure.dart';
import '../../../../../core/uscecase/usecase.dart';
import '../repositories/question_repository.dart';

class FinishQuizUseCase
    extends UseCase<Either<Failure, ApiResponse>, FinishQuizAnswer> {
  final IQuizRepository repository;
  FinishQuizUseCase(this.repository);
  @override
  Future<Either<Failure, ApiResponse>> call({FinishQuizAnswer? p}) async {
    return await repository.postQuestionAnswer(p!);
  }
}
