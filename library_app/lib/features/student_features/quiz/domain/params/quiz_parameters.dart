import 'package:equatable/equatable.dart';
import 'package:library_app/features/student_features/quiz/data/enums/quiz_type_enum.dart';

class QuizParameters extends Equatable {
  final String bookID;
  final String assignmentID;
  final QuizTypeEnum quizType;
  const QuizParameters(
      {required this.assignmentID,
      required this.bookID,
      required this.quizType});

  @override
  List<Object?> get props => [
        bookID,
        assignmentID,
      ];
}
