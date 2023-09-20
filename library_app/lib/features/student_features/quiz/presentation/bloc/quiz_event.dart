part of 'quiz_bloc.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object> get props => [];
}

class FetchQuestions extends QuizEvent {
  final String bookID;
  const FetchQuestions({required this.bookID});
}
