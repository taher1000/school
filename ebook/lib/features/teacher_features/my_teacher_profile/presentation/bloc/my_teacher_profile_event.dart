part of 'my_teacher_profile_bloc.dart';

abstract class MyTeacherProfileEvent extends Equatable {
  const MyTeacherProfileEvent();

  @override
  List<Object> get props => [];
}

class GetTeacherProfileInfoEvent extends MyTeacherProfileEvent {}
