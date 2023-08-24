part of 'my_books_bloc.dart';

abstract class MyBooksEvent extends Equatable {
  const MyBooksEvent();

  @override
  List<Object> get props => [];
}

class FetchMyBooks extends MyBooksEvent {
  int? bookLevel;
  FetchMyBooks({this.bookLevel});
}
