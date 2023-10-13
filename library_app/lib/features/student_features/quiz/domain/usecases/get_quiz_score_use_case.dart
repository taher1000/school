import 'package:dartz/dartz.dart';
import '../../../../../core/network/failure.dart';
import '../../../../../core/uscecase/usecase.dart';
import '../../data/models/response/quiz_score.dart';
import '../params/quiz_parameters.dart';
import '../repositories/question_repository.dart';

class GetQuizScoreUseCase
    extends UseCase<Either<Failure, List<QuizScoreModel>>, String> {
  final IQuizRepository repository;
  GetQuizScoreUseCase(this.repository);
  @override
  Future<Either<Failure, List<QuizScoreModel>>> call({String? p}) async {
    return await repository.getQuizScore(p!);
  }
}
