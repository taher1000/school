part of 'my_student_profile_bloc.dart';

abstract class MyStudentProfileEvent extends Equatable {
  const MyStudentProfileEvent();

  @override
  List<Object> get props => [];
}

class GetStudentProfileInfoEvent extends MyStudentProfileEvent {}
