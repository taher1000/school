import 'package:dartz/dartz.dart';
import '../../../../../core/models/assignment/student_assignment_summary_response.dart';
import '../../../my_favorites/data/models/favorite_book_summary_response.dart';
import '../../data/models/questions_summary_response.dart';
import '../entities/request/question_answer.dart';

import '../../../../../core/network/failure.dart';
import '../../data/models/response/quiz_score.dart';

abstract class IQuizRepository {
  Future<Either<Failure, QuestionsSummaryResponsePage>> getQuestions(
      int pageNumber,
      {required int pageSize,
      required String bookID});
  Future<Either<Failure, String>> finishQuiz(
      List<QuestionAnswer> questionAnswers);
  Future<Either<Failure, List<QuizScoreModel>>> getQuizScore(String bookID);
}
