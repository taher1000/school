import 'package:library_app/core/network/api_url.dart';

enum QuizTypeEnum { general, deductive, evaluative }

extension QuizTypeEnumExtension on QuizTypeEnum {
  String get url {
    switch (this) {
      case QuizTypeEnum.general:
        return ApiURLs.getGeneralQuestionPath;
      case QuizTypeEnum.deductive:
        return ApiURLs.getDeductiveQuestionPath;
      case QuizTypeEnum.evaluative:
        return ApiURLs.getEvaluativeQuestionPath;
      default:
        return ApiURLs.getGeneralQuestionPath;
    }
  }
}
