import 'package:library_app/features/student_features/quiz/data/enums/quiz_type_enum.dart';

import '../models/request/finish_quiz_answer.dart';
import '../../domain/entities/request/finish_quiz_answer.dart';

import '../../../../../core/network/api_response_model.dart';
import '../../../../../core/network/api_url.dart';
import '../../../../../core/network/school_rest.dart';
import '../../../../../injection_container.dart';

abstract class IQuizDataSource {
  Future<ApiResponse> getGeneralQuestions(QuizTypeEnum quizType,
      {required String bookID, required String assignmentID});
  Future<ApiResponse> getDeductiveQuestions(
      {required String bookID, required String assignmentID});
  Future<ApiResponse> getEvaluativeQuestions(
      {required String bookID, required String assignmentID});
  Future<ApiResponse> postQuestionAnswer(FinishQuizAnswer questionAnswers);
  Future<ApiResponse> getQuizScore(String bookID);
}

class QuizDataSource implements IQuizDataSource {
  final ISchoolRest rest;

  QuizDataSource(this.rest);

  @override
  Future<ApiResponse> getGeneralQuestions(QuizTypeEnum quizType,
      {required String bookID, required String assignmentID}) async {
    final url = quizType == QuizTypeEnum.general
        ? ApiURLs.getGeneralQuestionPath
        : quizType == QuizTypeEnum.deductive
            ? ApiURLs.getDeductiveQuestionPath
            : ApiURLs.getEvaluativeQuestionPath;
    final response = await rest.get(
      '$url?BookID=$bookID&AssignmentID=$assignmentID',
      userToken: sharedPrefsClient.accessToken,
    );
    return response;
  }

  @override
  Future<ApiResponse> getDeductiveQuestions(
      {required String bookID, required String assignmentID}) async {
    final response = await rest.get(
      '${ApiURLs.getDeductiveQuestionPath}?BookID=$bookID&AssignmentID=$assignmentID',
      userToken: sharedPrefsClient.accessToken,
    );
    return response;
  }

  @override
  Future<ApiResponse> getEvaluativeQuestions(
      {required String bookID, required String assignmentID}) async {
    final response = await rest.get(
      '${ApiURLs.getEvaluativeQuestionPath}?BookID=$bookID&AssignmentID=$assignmentID',
      userToken: sharedPrefsClient.accessToken,
    );
    return response;
  }

  @override
  Future<ApiResponse> postQuestionAnswer(
      FinishQuizAnswer questionAnswers) async {
    final response = await rest.post(
      ApiURLs.getFinishQuizPath,
      userToken: sharedPrefsClient.accessToken,
      data: questionAnswers.toModel().toJson(),
    );
    return response;
  }

  @override
  Future<ApiResponse> getQuizScore(String bookID) async {
    final response = await rest.get(
      '${ApiURLs.getQuizResultPath}?BookID=$bookID',
      userToken: sharedPrefsClient.accessToken,
    );
    return response;
  }
}
