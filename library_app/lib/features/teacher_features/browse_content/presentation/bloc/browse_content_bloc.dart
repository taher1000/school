import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'browse_content_event.dart';
part 'browse_content_state.dart';

class BrowseContentBloc extends Bloc<BrowseContentEvent, BrowseContentState> {
  BrowseContentBloc() : super(BrowseContentInitial()) {
    on<BrowseContentEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
