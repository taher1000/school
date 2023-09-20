class QuizScore {
  final String title;
  final int totalAnswerPoint;
  final int totalQuizPoint;
  final int answerPercentage;
  final bool hasResult;
  final bool hasPassed;
  final DateTime answerDate;

  QuizScore({
    required this.title,
    required this.totalAnswerPoint,
    required this.totalQuizPoint,
    required this.answerPercentage,
    required this.hasResult,
    required this.hasPassed,
    required this.answerDate,
  });
}
