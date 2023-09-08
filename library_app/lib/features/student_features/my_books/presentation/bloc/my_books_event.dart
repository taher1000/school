part of 'my_books_bloc.dart';

abstract class MyBooksEvent extends Equatable {
  const MyBooksEvent();

  @override
  List<Object> get props => [];
}

class FetchMyBooks extends MyBooksEvent {
  final int? bookLevel;
  const FetchMyBooks({this.bookLevel});
}
