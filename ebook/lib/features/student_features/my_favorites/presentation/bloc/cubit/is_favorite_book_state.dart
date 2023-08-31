part of 'is_favorite_book_cubit.dart';

sealed class IsFavoriteBookState extends Equatable {
  const IsFavoriteBookState();

  @override
  List<Object> get props => [];
}

final class IsFavoriteBookInitial extends IsFavoriteBookState {}

final class IsFavoriteBookLoading extends IsFavoriteBookState {}

final class IsFavoriteBookLoaded extends IsFavoriteBookState {
  final bool isFavorite;

  const IsFavoriteBookLoaded(this.isFavorite);

  @override
  List<Object> get props => [isFavorite];
}

final class IsFavoriteBookError extends IsFavoriteBookState {
  final String message;

  const IsFavoriteBookError(this.message);

  @override
  List<Object> get props => [message];
}
