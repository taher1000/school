part of 'books_bloc.dart';

abstract class BooksEvent extends Equatable {}

class FetchBooks extends BooksEvent {
  int? bookLevel;
  FetchBooks({this.bookLevel});
  @override
  List<Object?> get props => [];
}
