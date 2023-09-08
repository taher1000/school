part of 'books_bloc.dart';

abstract class BooksEvent extends Equatable {}

class FetchBooks extends BooksEvent {
  int? bookLevel;
  FetchBooks({this.bookLevel});
  @override
  List<Object?> get props => [];
}

class FetchBooksWithLevel extends BooksEvent {
  int bookLevel;
  FetchBooksWithLevel({required this.bookLevel});
  @override
  List<Object?> get props => [];
}
