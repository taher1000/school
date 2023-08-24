part of 'my_books_bloc.dart';

abstract class MyBooksState extends Equatable {
  const MyBooksState();

  @override
  List<Object> get props => [];
}

class MyBooksInitial extends MyBooksState {}

class GetMyBooksLoading extends MyBooksState {}

class GetMyBooksError extends MyBooksState {
  final String message;
  const GetMyBooksError({required this.message});
}

class GetMyBooksEmpty extends MyBooksState {}

class GetMyBooksLoaded extends MyBooksState {
  final BookSummaryResponsePage books;
  final LoadingMore? loading;
  final LoadMoreError? error;
  const GetMyBooksLoaded({
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
