import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'my_favorites_event.dart';
part 'my_favorites_state.dart';

class MyFavoritesBloc extends Bloc<MyFavoritesEvent, MyFavoritesState> {
  MyFavoritesBloc() : super(MyFavoritesInitial()) {
    on<MyFavoritesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
