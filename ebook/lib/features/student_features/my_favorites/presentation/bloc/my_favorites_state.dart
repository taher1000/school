part of 'my_favorites_bloc.dart';

abstract class MyFavoritesState extends Equatable {
  const MyFavoritesState();

  @override
  List<Object> get props => [];
}

class MyFavoritesInitial extends MyFavoritesState {}

class GetMyFavorites extends MyFavoritesState {}

class GetMyFavoritesLoading extends MyFavoritesState {}

class GetMyFavoritesError extends MyFavoritesState {
  final String message;
  const GetMyFavoritesError({required this.message});
}

class GetMyFavoritesEmpty extends MyFavoritesState {}

class GetMyFavoritesLoaded extends MyFavoritesState {
  final FavoriteBookSummaryResponsePage favoriteBooks;
  const GetMyFavoritesLoaded({
    required this.favoriteBooks,
  });
}
