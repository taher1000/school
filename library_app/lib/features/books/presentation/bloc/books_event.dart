part of 'books_bloc.dart';

abstract class BooksEvent extends Equatable {
  const BooksEvent();
  @override
  List<Object> get props => [];
}

class FetchBooks extends BooksEvent {
  final int? bookLevel;
  final bool isRefresh;
  const FetchBooks({this.bookLevel, this.isRefresh = false});
}
