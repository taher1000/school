part of 'my_favorites_bloc.dart';

class MyFavoritesState extends Equatable {
  final RequestStatus status;
  final List<FavoriteBook> books;
  final bool hasReachedMax;
  final String errorMessage;

  const MyFavoritesState({
    this.books = const [],
    this.status = RequestStatus.loading,
    this.hasReachedMax = false,
    this.errorMessage = '',
  });
  MyFavoritesState copyWith({
    RequestStatus? status,
    List<FavoriteBook>? books,
    bool? hasReachedMax,
    String? errorMessage,
    int? currentPageNumber,
  }) {
    return MyFavoritesState(
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
