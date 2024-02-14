part of 'my_student_profile_bloc.dart';

abstract class MyStudentProfileState extends Equatable {
  const MyStudentProfileState();

  @override
  List<Object> get props => [];
}

class MyStudentProfileInitial extends MyStudentProfileState {}

class MyStudentProfileLoading extends MyStudentProfileState {}

class MyStudentProfileLoaded extends MyStudentProfileState {
  final UserData userData;

  const MyStudentProfileLoaded(this.userData);

  @override
  List<Object> get props => [userData];
}

class MyStudentProfileError extends MyStudentProfileState {
  final String message;

  const MyStudentProfileError(this.message);

  @override
  List<Object> get props => [message];
}
