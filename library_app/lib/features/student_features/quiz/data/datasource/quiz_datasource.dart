import '../models/request/question_answer.dart';
import '../../domain/entities/request/question_answer.dart';

import '../../../../../core/network/api_response_model.dart';
import '../../../../../core/network/api_url.dart';
import '../../../../../core/network/school_rest.dart';
import '../../../../../injection_container.dart';

abstract class IQuizDataSource {
  Future<ApiResponse> getQuestions(int pageNumber,
      {required int pageSize, required String bookID});
  Future<ApiResponse> finishQuiz(List<QuestionAnswer> questionAnswers);
  Future<ApiResponse> getQuizScore(String bookID);
}

class QuizDataSource implements IQuizDataSource {
  final ISchoolRest rest;

  QuizDataSource(this.rest);

  @override
  Future<ApiResponse> getQuestions(int pageNumber,
      {required int pageSize, required String bookID}) async {
    final response = await rest.get(
      '${ApiURLs.getQuizPath}?PageNumber=$pageNumber&PageSize=$pageSize&BookID=$bookID',
      userToken: sharedPrefsClient.accessToken,
    );
    return response;
  }

  @override
  Future<ApiResponse> finishQuiz(List<QuestionAnswer> questionAnswers) async {
    final response = await rest.post(
      ApiURLs.getFinishQuizPath,
      userToken: sharedPrefsClient.accessToken,
      data: questionAnswerModelToJson(
          questionAnswers.map((e) => e.toModel()).toList()),
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
