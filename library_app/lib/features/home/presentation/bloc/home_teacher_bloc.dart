import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_teacher_event.dart';
part 'home_teacher_state.dart';

class HomeTeacherBloc extends Bloc<HomeTeacherEvent, HomeTeacherState> {
  HomeTeacherBloc() : super(HomeTeacherInitial()) {
    on<HomeTeacherEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
