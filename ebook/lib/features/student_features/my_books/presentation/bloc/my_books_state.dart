part of 'my_books_bloc.dart';

class MyBooksState extends Equatable {
  final BookSummaryResponsePage? books;

  const MyBooksState({
    this.books,
  });
  MyBooksState copyWith({BookSummaryResponsePage? books}) {
    return MyBooksState(
      books: books ?? this.books,
    );
  }

  @override
  List<Object> get props => [];
}

class MyBooksInitial extends MyBooksState {}

class GetMyBooksLoading extends MyBooksState {}

class GetMyBooksError extends MyBooksState {
  final String message;
  const GetMyBooksError({required this.message});
}
