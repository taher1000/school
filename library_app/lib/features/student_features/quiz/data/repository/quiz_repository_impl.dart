import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:library_app/features/student_features/quiz/data/models/question.dart';
import 'package:library_app/features/student_features/quiz/data/models/response/quiz_score.dart';
import 'package:library_app/features/student_features/quiz/domain/entities/request/question_answer.dart';
import '../../../../../core/network/failure.dart';
import '../../domain/repositories/question_repository.dart';
import '../datasource/quiz_datasource.dart';
import '../models/questions_summary_response.dart';

class QuizRepositoryImpl extends IQuizRepository {
  final IQuizDataSource remoteDataSource;

  QuizRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, QuestionsSummaryResponsePage>> getQuestions(
      int pageNumber,
      {required int pageSize,
      required String bookID}) async {
    try {
      var response = await remoteDataSource.getQuestions(pageNumber,
          pageSize: pageSize, bookID: bookID);
      if (response.errors!.isEmpty && response.succeeded!) {
        return Right(QuestionsSummaryResponsePage(
          pageNumber: response.pageNumber,
          data: List<QuestionModel>.from(
              response.data!.map((x) => QuestionModel.fromJson(x))),
          nextPage: response.nextPage,
          message: response.message,
          errors: response.errors,
          succeeded: response.succeeded,
          pageSize: response.pageSize,
          totalPages: response.totalPages,
          totalRecords: response.totalRecords,
        ));
      } else {
        return Left(Failure(message: response.message!));
      }
    } on DioException catch (_) {
      return const Left(Failure(message: "error_message"));
    }
  }

  @override
  Future<Either<Failure, String>> finishQuiz(
      List<QuestionAnswer> questionAnswers) async {
    try {
      var response = await remoteDataSource.finishQuiz(questionAnswers);
      if (response.errors!.isEmpty && response.succeeded!) {
        return Right(response.message!);
      } else {
        return Left(Failure(message: response.errors![0]));
      }
    } on DioException catch (_) {
      return const Left(Failure(message: "error_message"));
    }
  }

  @override
  Future<Either<Failure, List<QuizScoreModel>>> getQuizScore(
      String bookID) async {
    try {
      var response = await remoteDataSource.getQuizScore(bookID);
      if (response.errors!.isEmpty && response.succeeded!) {
        final resultList = <QuizScoreModel>[];
        for (var i = 0; i < response.data.length; i++) {
          resultList.add(QuizScoreModel.fromJson(response.data[i]));
        }
        // final data = List<QuizScoreModel>.from(response.data);
        // final data = quizScoreModelFromJson(response.data);
        return Right(resultList);
      } else {
        return Left(Failure(message: response.errors![0]));
      }
    } on DioException catch (_) {
      return const Left(Failure(message: "error_message"));
    }
  }
}
