part of 'books_bloc.dart';

class BooksState extends Equatable {
  final BookSummaryResponsePage? books;

  const BooksState({
    this.books,
  });
  BooksState copyWith({BookSummaryResponsePage? books}) {
    return BooksState(
      books: books ?? this.books,
    );
  }

  @override
  List<Object> get props => [];
}

class BooksInitial extends BooksState {}

class GetBooksLoading extends BooksState {}

class GetBooksError extends BooksState {
  final String message;
  const GetBooksError({required this.message});
}

class GetBooksEmpty extends BooksState {}

class GetBooksLoaded extends BooksState {
  final BookSummaryResponsePage books;
  const GetBooksLoaded({
    required this.books,
  });
}
