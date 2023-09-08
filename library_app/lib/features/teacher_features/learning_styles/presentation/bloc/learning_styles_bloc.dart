import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'learning_styles_event.dart';
part 'learning_styles_state.dart';

class LearningStylesBloc extends Bloc<LearningStylesEvent, LearningStylesState> {
  LearningStylesBloc() : super(LearningStylesInitial()) {
    on<LearningStylesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
