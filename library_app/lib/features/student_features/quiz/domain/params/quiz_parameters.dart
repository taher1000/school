import 'package:equatable/equatable.dart';

class QuizParameters extends Equatable {
  final int pageNumber;
  final int pageSize;
  final String bookID;
  const QuizParameters(
      {required this.pageNumber, required this.pageSize, required this.bookID});

  @override
  List<Object?> get props => [];
}
