part of 'books_bloc.dart';

abstract class BooksEvent extends Equatable {}

class FetchBooks extends BooksEvent {
  @override
  List<Object?> get props => [];
}
