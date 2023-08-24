import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'my_assignments_event.dart';
part 'my_assignments_state.dart';

class MyAssignmentsBloc extends Bloc<MyAssignmentsEvent, MyAssignmentsState> {
  MyAssignmentsBloc() : super(MyAssignmentsInitial()) {
    on<MyAssignmentsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
