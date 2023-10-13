import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:library_app/features/student_features/quiz/domain/entities/question.dart';
import '../../../../../core/network/api_response_model.dart';
import '../enums/quiz_type_enum.dart';
import '../models/question.dart';
import '../models/response/quiz_score.dart';
import '../../domain/entities/request/finish_quiz_answer.dart';
import '../../../../../core/network/failure.dart';
import '../../domain/repositories/question_repository.dart';
import '../datasource/quiz_datasource.dart';

class QuizRepositoryImpl extends IQuizRepository {
  final IQuizDataSource remoteDataSource;

  QuizRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Question>>> getGeneralQuestions(
      QuizTypeEnum quizType,
      {required String bookID,
      required String assignmentID}) async {
    try {
      var response = await remoteDataSource.getGeneralQuestions(quizType,
          bookID: bookID, assignmentID: assignmentID);
      if (response.errors!.isEmpty && response.succeeded!) {
        final resultList = <Question>[];
        for (var i = 0; i < response.data.length; i++) {
          resultList.add(QuestionModel.fromJson(response.data[i]));
        }
        return Right(resultList);
      } else {
        return Left(Failure(message: response.errors![0]));
      }
    } on DioException catch (_) {
      return const Left(Failure(message: "error_message"));
    }
  }

  @override
  Future<Either<Failure, List<Question>>> getDeductiveQuestions(
      {required String bookID, required String assignmentID}) async {
    try {
      var response = await remoteDataSource.getDeductiveQuestions(
          bookID: bookID, assignmentID: assignmentID);
      if (response.errors!.isEmpty && response.succeeded!) {
        final resultList = <Question>[];
        for (var i = 0; i < response.data.length; i++) {
          resultList.add(QuestionModel.fromJson(response.data[i]));
        }
        return Right(resultList);
      } else {
        return Left(Failure(message: response.errors![0]));
      }
    } on DioException catch (_) {
      return const Left(Failure(message: "error_message"));
    }
  }

  @override
  Future<Either<Failure, List<Question>>> getEvaluativeQuestions(
      {required String bookID, required String assignmentID}) async {
    try {
      var response = await remoteDataSource.getEvaluativeQuestions(
          bookID: bookID, assignmentID: assignmentID);
      if (response.errors!.isEmpty && response.succeeded!) {
        final resultList = <Question>[];
        for (var i = 0; i < response.data.length; i++) {
          resultList.add(QuestionModel.fromJson(response.data[i]));
        }
        return Right(resultList);
      } else {
        return Left(Failure(message: response.errors![0]));
      }
    } on DioException catch (_) {
      return const Left(Failure(message: "error_message"));
    }
  }

  @override
  Future<Either<Failure, ApiResponse>> postQuestionAnswer(
      FinishQuizAnswer questionAnswers) async {
    try {
      var response = await remoteDataSource.postQuestionAnswer(questionAnswers);
      if (response.errors!.isEmpty) {
        return Right(response);
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
