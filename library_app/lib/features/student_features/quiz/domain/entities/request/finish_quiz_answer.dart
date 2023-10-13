import '../../../data/models/request/finish_quiz_answer.dart';
import 'choice_answer.dart';

class FinishQuizAnswer {
  final String assignmentId;
  final String bookId;
  final String questionCategoryId;
  final List<ChoiceAnswer> choiceAnswer;

  FinishQuizAnswer({
    required this.assignmentId,
    required this.bookId,
    required this.questionCategoryId,
    required this.choiceAnswer,
  });

  FinishQuizAnswerModel toModel() {
    return FinishQuizAnswerModel(
      assignmentId: assignmentId,
      bookId: bookId,
      questionCategoryId: questionCategoryId,
      choiceAnswer: choiceAnswer.map((e) => e.toModel()).toList(),
    );
  }
}
