import 'package:dartz/dartz.dart';
import 'package:library_app/core/network/api_response_model.dart';
import 'package:library_app/features/student_features/quiz/domain/entities/question.dart';
import '../../../../../core/models/assignment/student_assignment_summary_response.dart';
import '../../../my_favorites/data/models/favorite_book_summary_response.dart';
import '../../data/enums/quiz_type_enum.dart';
import '../entities/request/finish_quiz_answer.dart';

import '../../../../../core/network/failure.dart';
import '../../data/models/response/quiz_score.dart';

abstract class IQuizRepository {
  Future<Either<Failure, List<Question>>> getGeneralQuestions(
      QuizTypeEnum quizType,
      {required String bookID,
      required String assignmentID});
  Future<Either<Failure, List<Question>>> getDeductiveQuestions(
      {required String bookID, required String assignmentID});
  Future<Either<Failure, List<Question>>> getEvaluativeQuestions(
      {required String bookID, required String assignmentID});
  Future<Either<Failure, ApiResponse>> postQuestionAnswer(
      FinishQuizAnswer questionAnswers);
  Future<Either<Failure, List<QuizScoreModel>>> getQuizScore(String bookID);
}
