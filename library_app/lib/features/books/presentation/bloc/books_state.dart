part of 'books_bloc.dart';

class BooksState extends Equatable {
  final RequestStatus status;
  final List<Book> books;
  final bool hasReachedMax;
  final String errorMessage;

  const BooksState({
    this.books = const [],
    this.status = RequestStatus.loading,
    this.hasReachedMax = false,
    this.errorMessage = '',
  });
  BooksState copyWith({
    RequestStatus? status,
    List<Book>? books,
    bool? hasReachedMax,
    String? errorMessage,
    int? currentPageNumber,
  }) {
    return BooksState(
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
