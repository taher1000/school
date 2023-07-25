part of 'books_bloc.dart';

abstract class BooksEvent extends Equatable {
  List<Book> books;
  BooksEvent(this.books);

  @override
  List<Object> get props => [];
}

class GetBooksEvent extends BooksEvent {
  GetBooksEvent(List<Book> books) : super(books);
}
