import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'student_activities_event.dart';
part 'student_activities_state.dart';

class StudentActivitiesBloc extends Bloc<StudentActivitiesEvent, StudentActivitiesState> {
  StudentActivitiesBloc() : super(StudentActivitiesInitial()) {
    on<StudentActivitiesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
