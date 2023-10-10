part of 'my_books_bloc.dart';

class MyBooksState extends Equatable {
  final RequestStatus status;
  final List<Book> books;
  final bool hasReachedMax;
  final String errorMessage;

  const MyBooksState({
    this.books = const [],
    this.status = RequestStatus.loading,
    this.hasReachedMax = false,
    this.errorMessage = '',
  });
  MyBooksState copyWith({
    RequestStatus? status,
    List<Book>? books,
    bool? hasReachedMax,
    String? errorMessage,
    int? currentPageNumber,
  }) {
    return MyBooksState(
      books: books ?? this.books,
      status: status ?? this.status,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        books,
        hasReachedMax,
        errorMessage,
      ];
}
