import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'assignment_event.dart';
part 'assignment_state.dart';

class AssignmentBloc extends Bloc<AssignmentEvent, AssignmentState> {
  AssignmentBloc() : super(AssignmentInitial()) {
    on<AssignmentEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
