part of 'books_bloc.dart';

abstract class BooksState extends Equatable {
  const BooksState();

  @override
  List<Object> get props => [];
}

class BooksInitial extends BooksState {}

class GetBooks extends BooksState {}

class GetBooksLoading extends BooksState {}

class GetBooksError extends BooksState {
  final String message;
  const GetBooksError({required this.message});
}

class GetBooksEmpty extends BooksState {}

class GetBooksLoaded extends BooksState {
  final BookSummaryResponsePage books;
  final LoadingMore? loading;
  final LoadMoreError? error;
  const GetBooksLoaded({
    required this.books,
    this.loading,
    this.error,
  });
}

// LoadingMore Model
class LoadingMore {
  final String message;
  LoadingMore({required this.message});
}

// LoadingMoreError Model
class LoadMoreError {
  final String message;
  LoadMoreError({required this.message});
}
