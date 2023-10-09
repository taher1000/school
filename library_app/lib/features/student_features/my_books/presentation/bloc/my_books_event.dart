part of 'my_books_bloc.dart';

abstract class MyBooksEvent extends Equatable {
  const MyBooksEvent();

  @override
  List<Object> get props => [];
}

class FetchMyBooks extends MyBooksEvent {
  final int? bookLevel;
  final bool isRefresh;
  const FetchMyBooks({this.bookLevel, this.isRefresh = false});
}
