part of 'my_favorites_bloc.dart';

abstract class MyFavoritesEvent extends Equatable {
  const MyFavoritesEvent();

  @override
  List<Object> get props => [];
}

class FetchMyFavorites extends MyFavoritesEvent {
  final int? bookLevel;
  const FetchMyFavorites({this.bookLevel});
}
