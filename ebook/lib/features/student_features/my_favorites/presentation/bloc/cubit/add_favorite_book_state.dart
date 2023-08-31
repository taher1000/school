part of 'add_favorite_book_cubit.dart';

sealed class AddFavoriteBookState extends Equatable {
  const AddFavoriteBookState();

  @override
  List<Object> get props => [];
}

final class AddFavoriteBookInitial extends AddFavoriteBookState {}

final class AddFavoriteBookLoading extends AddFavoriteBookState {}

final class AddFavoriteBookError extends AddFavoriteBookState {
  final String message;

  const AddFavoriteBookError({required this.message});

  @override
  List<Object> get props => [message];
}

final class AddFavoriteBookSuccess extends AddFavoriteBookState {
  final String message;

  const AddFavoriteBookSuccess({required this.message});

  @override
  List<Object> get props => [message];
}
