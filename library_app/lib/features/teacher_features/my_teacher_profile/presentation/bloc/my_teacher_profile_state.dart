part of 'my_teacher_profile_bloc.dart';

abstract class MyTeacherProfileState extends Equatable {
  const MyTeacherProfileState();

  @override
  List<Object> get props => [];
}

class MyTeacherProfileInitial extends MyTeacherProfileState {}

class MyTeacherProfileLoading extends MyTeacherProfileState {}

class MyTeacherProfileLoaded extends MyTeacherProfileState {
  final UserData userData;

  const MyTeacherProfileLoaded(this.userData);

  @override
  List<Object> get props => [userData];
}

class MyTeacherProfileError extends MyTeacherProfileState {
  final String message;

  const MyTeacherProfileError(this.message);

  @override
  List<Object> get props => [message];
}
