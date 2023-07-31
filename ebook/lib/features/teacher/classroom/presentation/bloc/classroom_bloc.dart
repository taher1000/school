import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'classroom_event.dart';
part 'classroom_state.dart';

class ClassroomBloc extends Bloc<ClassroomEvent, ClassroomState> {
  ClassroomBloc() : super(ClassroomInitial()) {
    on<ClassroomEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
